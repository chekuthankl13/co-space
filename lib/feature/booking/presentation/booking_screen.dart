import 'package:co_workspace/core/config/config.dart';
import 'package:co_workspace/core/utils/utils.dart';
import 'package:co_workspace/feature/booking/domain/entity/booking_entity.dart';
import 'package:co_workspace/feature/booking/logic/booking_cubit.dart';
import 'package:co_workspace/feature/details/presentation/widgets/detail_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text("My Bookings"),
      ),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          switch (state) {
            case Loading _:
              return loading(clr: Config.greenClr);
            case Error e:
              return error(
                e.error,
                onPressed: () => context.read<BookingCubit>().loadBooking(),
              );

            case Loaded ld:
              return body(ld.bookings);
            default:
              return loading(clr: Config.greenClr);
          }
        },
      ),
    );
  }

  Widget body(List<BookingEntity> bookings) {
    return bookings.isEmpty
        ? itemEmpty(context, "No Booking Found !!", isCenter: false)
        : ListView.builder(
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              var data = bookings[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 2,
                  surfaceTintColor: Colors.white,
                  child: SizedBox(
                    // height: 180,
                    width: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              child: Image.asset(
                                "assets/images/${data.space.images[0]}",

                                height: 120,
                                width: sW(context),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => AlertDialog(
                                      insetPadding: EdgeInsets.all(10),
                                      backgroundColor: Colors.white,
                                      titlePadding: EdgeInsets.all(20),
                                      titleTextStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Config.baseClr,
                                      ),
                                      title: Text("Book"),

                                      contentPadding: EdgeInsets.all(10),
                                      actions: [
                                        DetailWidgets().text(
                                          txt: "Cancel",
                                          onPressed: () {
                                            navigatorKey.currentState!.pop();
                                          },
                                          color: Colors.green,
                                        ),

                                        DetailWidgets().normal(
                                          size: Size(100, 35),

                                          txt: "Delete",
                                          onPressed: () async {
                                            EasyLoading.show();
                                            var res = await context
                                                .read<BookingCubit>()
                                                .delete(index.toString());

                                            if (res['status'] == "ok") {
                                              EasyLoading.dismiss();
                                              EasyLoading.showSuccess(
                                                "successfully Deleted !!",
                                              );
                                              navigatorKey.currentState!.pop();
                                              // ignore: use_build_context_synchronously
                                              context
                                                  .read<BookingCubit>()
                                                  .loadBooking();
                                            } else {
                                              EasyLoading.dismiss();
                                              EasyLoading.showError(
                                                res['error'],
                                              );
                                            }
                                          },
                                          color: Colors.red,
                                        ),
                                      ],
                                      content: Text(
                                        "Are you sure ? \n you want to delete the booking ..",
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4.5),
                                    ),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.red,
                                    size: 17,
                                    shadows: [],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black12,
                                      Colors.black12,
                                      Colors.black87,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              bottom: 5,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "${data.space.pricePerHour}/hour",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tile(title: "Name", val: data.name),
                              tile(title: "No Of Seats", val: data.seat),
                              tile(title: "Start Date", val: data.sDate),
                              tile(title: "End Date", val: data.eDate),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:
                                          status(
                                                sDate: data.sDate,
                                                eDate: data.eDate,
                                              ) ==
                                              "Upcoming"
                                          ? Colors.greenAccent
                                          : status(
                                                  sDate: data.sDate,
                                                  eDate: data.eDate,
                                                ) ==
                                                "Expired"
                                          ? Colors.red
                                          : Colors.amber,
                                    ),
                                    child: Text(
                                      status(
                                        sDate: data.sDate,
                                        eDate: data.eDate,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  String status({sDate, eDate}) {
    final now = DateTime.now();
    final start = DateTime.parse(sDate);
    final end = DateTime.parse(eDate);

    if (now.isBefore(start)) {
      return 'Upcoming';
    } else if (now.isAfter(end)) {
      return 'Expired';
    } else {
      return 'Ongoing';
    }
  }

  Widget tile({required title, required val}) {
    return Row(
      children: [
        Text(
          title + " : ",
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Config.grey2Clr,
          ),
        ),
        Expanded(
          child: Text(
            val,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
