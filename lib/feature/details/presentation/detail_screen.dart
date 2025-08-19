import 'package:carousel_slider/carousel_slider.dart';
import 'package:co_workspace/common/cubits/int_cubit.dart';
import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/core/config/config.dart';
import 'package:co_workspace/core/utils/utils.dart';
import 'package:co_workspace/feature/details/logic/detail_cubit.dart';
import 'package:co_workspace/feature/details/presentation/widgets/detail_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  CarouselSliderController controller = CarouselSliderController();

  TextEditingController nameCntr = TextEditingController();
  TextEditingController timeCntr = TextEditingController();
  TextEditingController sdateCntr = TextEditingController();
  TextEditingController eDateCntr = TextEditingController();
  TextEditingController seatCntr = TextEditingController();

  GlobalKey<FormState> fKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<IntCubit>().update(0);
    super.initState();
  }

  @override
  void dispose() {
    nameCntr.dispose();
    timeCntr.dispose();
    sdateCntr.dispose();
    eDateCntr.dispose();
    seatCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailCubit, DetailState>(
      builder: (context, state) {
        switch (state) {
          case Loading _:
            return scafoldloading();
          case Error e:
            return scafolderror(
              e.error,
              onPressed: () => context.read<DetailCubit>().getDetail(widget.id),
            );

          case Detail d:
            return body(d.detail);
          default:
            return scafoldloading();
        }
      },
    );
  }

  Widget body(SpaceEntity detail) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: btmNav(detail),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          Stack(
            children: [
              CarouselSlider(
                carouselController: controller,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    context.read<IntCubit>().update(index);
                  },
                  // enlargeCenterPage: true,
                  height: sH(context) / 2.5,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  aspectRatio: 1,
                  // autoPlay: true,
                  viewportFraction: 1,
                ),
                items: detail.images.map((i) {
                  return Image.asset(
                    "assets/images/$i",
                    // height: sH(context) / 3,
                    width: sW(context),
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () => navigatorKey.currentState!.pop(),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 25,
                      color: Config.greenClr,
                    ),
                  ),
                ),
              ),
             
            ],
          ),
          spaceHeight(10),
          BlocBuilder<IntCubit, int>(
            builder: (context, intstate) => SizedBox(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: detail.images.length,
                itemBuilder: (context, index) {
                  var data = detail.images[index];
                  return GestureDetector(
                    onTap: () {
                      controller.jumpToPage(index);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: intstate == index
                            ? [
                                const BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 1,
                                ),
                              ]
                            : [],
                        border: intstate == index
                            ? Border.all(color: Config.greenClr)
                            : null,
                        image: DecorationImage(
                          image: AssetImage("assets/images/$data"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          spaceHeight(5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              detail.name,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ),
          spaceHeight(5),
          Row(
            children: [
              spaceWidth(10),
              Icon(CupertinoIcons.location, color: Config.greenClr, size: 15),
              spaceWidth(5),
              Expanded(
                child: Text(
                  detail.location,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ],
          ),
          spaceHeight(15),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: sW(context),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Config.greenClr, blurRadius: .5)],
              ),
              child: Row(
                children: [
                  DetailWidgets().tile(
                    title: "Hot Desks",
                    ic: CupertinoIcons.decrease_indent,
                  ),
                  DetailWidgets().vertiDiv(),
                  DetailWidgets().tile(title: "Event Space", ic: Icons.event),
                  DetailWidgets().vertiDiv(),

                  DetailWidgets().tile(
                    title: "200 sq.ft",
                    ic: Icons.square_foot,
                  ),
                ],
              ),
            ),
          ),
          spaceHeight(2),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Config.baseClr,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(detail.discription, style: TextStyle(fontSize: 11)),
          ),

          spaceHeight(2),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Amenities",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Config.baseClr,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: detail.amenities.length,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              // childAspectRatio: 3 / 2,
              childAspectRatio: 1, //1/2
              mainAxisExtent: 40,
              crossAxisSpacing: 0, // 5,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              var data = detail.amenities[index];

              return Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                shadowColor: Config.greenClr,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,

                side: BorderSide(color: Config.greenClr),

                label: Text(data, style: const TextStyle(fontSize: 11)),
              );
            },
          ),
          spaceHeight(15),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Property Details",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Config.baseClr,
              ),
            ),
          ),

          spaceHeight(10),
          DetailWidgets().detailType(title: "Type", val: "Co workspace"),
          DetailWidgets().detailType(title: "Capacity", val: detail.capacity),

          DetailWidgets().detailType(title: "Furnishing", val: "Furnished"),
          DetailWidgets().detailType(title: "Rent Type", val: "Monthly"),
          DetailWidgets().detailType(title: "Security Period", val: "3 month"),
          DetailWidgets().detailType(
            title: "Security Amount",
            val: "\$${detail.pricePerHour}",
          ),
          DetailWidgets().detailType(title: "Owner Name", val: detail.owner),
          DetailWidgets().detailType(
            title: "Phone Number",
            val: detail.phoneNumber,
          ),

          spaceHeight(15),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Privacy Policy",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Config.baseClr,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(detail.privacy, style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget btmNav(SpaceEntity detail) => BottomAppBar(
    surfaceTintColor: Colors.white,
    color: Colors.white,
    elevation: 10,
    height: kTextTabBarHeight + 15,
    child: Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "\$ ${detail.pricePerHour}/Hour",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                "+3 month security deposit",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              nameCntr.clear();
              timeCntr.clear();
              sdateCntr.clear();
              eDateCntr.clear();
              seatCntr.clear();
              bookSheet(context, detail);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: Config.greenClr,
              foregroundColor: Colors.white,
            ),
            child: const Text("Book now", style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    ),
  );

  Future<dynamic> bookSheet(BuildContext context, SpaceEntity data) {
    return showDialog(
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

        content: SizedBox(
          width: sW(context),
          child: Form(
            key: fKey,
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                spacing: 10,
                children: [
                  DetailWidgets().field(
                    cntr: nameCntr,
                    txt: "Name",
                    isRead: false,
                    isIc: true,
                    ic: Icons.person,
                  ),
                  DetailWidgets().field(
                    cntr: seatCntr,
                    txt: "Seats",
                    isRead: false,
                    isIc: true,
                    isNum: true,
                    ic: Icons.cabin,
                  ),

                  DetailWidgets().field(
                    cntr: sdateCntr,
                    txt: "Start Date",
                    isRead: true,
                    isIc: true,
                    isNum: true,
                    isTrail: true,
                    ic: Icons.calendar_month,
                    ontap: () {
                      DetailWidgets().date(
                        context,
                        cntr: sdateCntr,
                        firstdate: DateTime(DateTime.now().year),
                        lastdate: DateTime(DateTime.now().year + 2),
                      );
                    },
                  ),

                  DetailWidgets().field(
                    cntr: eDateCntr,
                    txt: "End Date",
                    isRead: true,
                    isIc: true,
                    isNum: true,
                    isTrail: true,
                    ic: Icons.calendar_month,
                    ontap: () {
                      DetailWidgets().date(
                        context,
                        cntr: eDateCntr,
                        firstdate: DateTime(DateTime.now().day),
                        lastdate: DateTime(DateTime.now().year + 2),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DetailWidgets().text(
                        txt: "Close",
                        onPressed: () {
                          navigatorKey.currentState!.pop();
                        },
                        color: Colors.red,
                      ),

                      DetailWidgets().normal(
                        size: Size(100, 35),

                        txt: "Book",
                        onPressed: () async {
                          if (fKey.currentState!.validate()) {
                            EasyLoading.show();
                            var res = await context.read<DetailCubit>().book(
                              detail: data,
                              edate: eDateCntr.text,
                              name: nameCntr.text,
                              noSeats: seatCntr.text,
                              sdate: sdateCntr.text,
                              time: timeCntr.text,
                            );

                            if (res['status'] == "ok") {
                              EasyLoading.dismiss();
                              EasyLoading.showSuccess("successfully booked !!");
                              navigatorKey.currentState!.pop();
                            } else {
                              EasyLoading.dismiss();
                              EasyLoading.showError(res['error']);
                            }
                          }
                        },
                        color: Config.greenClr,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
