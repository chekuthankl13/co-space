import 'package:carousel_slider/carousel_slider.dart';
import 'package:co_workspace/common/int_cubit.dart';
import 'package:co_workspace/core/config/config.dart';
import 'package:co_workspace/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  CarouselSliderController controller = CarouselSliderController();

  @override
  void initState() {
    context.read<IntCubit>().update(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: btmNav(),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
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
            items: ["1", "2"].map((i) {
              return Image.asset(
                "assets/images/$i.jpg",
                // height: sH(context) / 3,
                width: sW(context),
                fit: BoxFit.cover,
              );
            }).toList(),
          ),
          spaceHeight(10),
          BlocBuilder<IntCubit, int>(
            builder: (context, intstate) => SizedBox(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: ["1", "2"].length,
                itemBuilder: (context, index) {
                  var data = ["1", "2"][index];
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
                            ? Border.all(color: Colors.white)
                            : null,
                        image: DecorationImage(
                          image: AssetImage("assets/images/$data.jpg"),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "NAME",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ),
          spaceHeight(5),
          Row(
            children: [
              spaceWidth(10),
              Icon(CupertinoIcons.location, color: Config.greenClr, size: 15),
              spaceWidth(5),
              const Expanded(
                child: Text(
                  "LOCATION",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, ),
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
                boxShadow: [
                  BoxShadow(color: Config.greenClr,blurRadius: .5)
                ],
                
               
              ),
              child: Row(
                children: [
                  tile(title: "Hot Desks", ic: CupertinoIcons.decrease_indent),
                  vertiDiv(),
                  tile(title: "Event Space", ic: Icons.event),
                  vertiDiv(),
                 
                  tile(title: "200 sq.ft", ic: Icons.square_foot),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ''',
              style: TextStyle(fontSize: 11, ),
            ),
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
            itemCount: amentiesList.length,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // childAspectRatio: 3 / 2,
              childAspectRatio: 1, //1/2
              mainAxisExtent: 40,
              crossAxisSpacing: 0, // 5,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              var data = amentiesList[index];

              return Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  // boxShadow: [
                  //   BoxShadow([200]!, blurRadius: 1),
                  // ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(data['ic'], size: 20, ),
                    spaceWidth(10),
                    Text(data['name'], style: const TextStyle(fontSize: 11)),
                  ],
                ),
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
          detailType(title: "Type", val: "Villa"),
          detailType(title: "Furnishing", val: "Furnished"),
          detailType(title: "Rent Type", val: "Monthly"),
          detailType(title: "Security Period", val: "3 month"),
          detailType(title: "Security Amount", val: "\$1000"),
          detailType(title: "landlord Name", val: "Hari"),
          detailType(title: "landlord Number", val: "984562317"),
        ],
      ),
    );
  }

  Expanded tile({required title, required ic}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(ic, size: 15, ),
          spaceHeight(5),
          Text(title, style: const TextStyle(fontSize: 11, )),
        ],
      ),
    );
  }

  Padding vertiDiv() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: VerticalDivider(color: Config.baseClr),
    );
  }

  final List<Map> amentiesList = [
    {"name": "Power Backup", "ic": Icons.battery_full_rounded},
    {"name": "Lockers", "ic": CupertinoIcons.lock},
    {"name": "Parking", "ic": Icons.local_parking},
    {"name": "Wifi", "ic": Icons.wifi},
    {"name": "Pantry", "ic": Icons.food_bank},
    {"name": "Lounge Areas", "ic": Icons.star},
   

  ];

  Padding detailType({required title, required val}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(val, style: const TextStyle(fontSize: 10))),
        ],
      ),
    );
  }









  Widget btmNav() => BottomAppBar(
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
                children: const [
                  Text(
                    "\$ 500/Month",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "+3 month security deposit",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Config.greenClr,
                    foregroundColor: Colors.white),
                child:  const Text(
                        "Book now",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
              ),
            )
          ],
        ),
      );
}
