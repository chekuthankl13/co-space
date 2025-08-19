import 'package:carousel_slider/carousel_slider.dart';
import 'package:co_workspace/core/config/config.dart';
import 'package:co_workspace/core/utils/utils.dart';
import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/feature/home/logic/cubit/home_cubit.dart';
import 'package:co_workspace/feature/home/logic/scroll_cubit.dart';
import 'package:co_workspace/feature/home/logic/slider_cubit.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController? _scrollCntr;

  @override
  void initState() {
    _scrollCntr = ScrollController();
    _scrollCntr!.addListener(() {
      if (_scrollCntr!.offset > 110) {
        context.read<ScrollCubit>().update(false);
        //change value = false;
      } else {
        context.read<ScrollCubit>().update(true);

        //chnage value = true;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollCntr?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollCntr,

        slivers: [
          SliverAppBar(
            title: RichText(
              text: TextSpan(
                text: "CO-SPACE ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Config.baseClr,
                ),
                children: [
                  TextSpan(
                    text: ".",
                    style: TextStyle(
                      color: Config.greenClr,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            surfaceTintColor: Colors.white,
            snap: false,
            pinned: true,
            floating: false,
            actions: [
              BlocBuilder<ScrollCubit, bool>(
                builder: (context, state) => !state
                    ? IconButton(
                        onPressed: () {
                          navigatorKey.currentState!.pushNamed("/search");
                        },
                        icon: Icon(Icons.search, color: Config.greyClr),
                      )
                    : empty(),
              ),
              IconButton(
                onPressed: () {
                  navigatorKey.currentState!.pushNamed("/map");
                },
                icon: const Icon(
                  Icons.location_on_outlined,
                  color: Config.greyClr,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: BlocBuilder<ScrollCubit, bool>(
                builder: (context, state) => state
                    ? GestureDetector(
                        onTap: () {
                          navigatorKey.currentState!.pushNamed("/search");
                        },
                        child: Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          // ignore: deprecated_member_use
                          shadowColor: Config.greenClr.withOpacity(.3),
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SizedBox(
                            height: 25,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "where to Find ?",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Config.greyClr,
                                    ),
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: Config.greyClr,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : empty(),
              ),

              expandedTitleScale: 1.5,
              background: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/build.jpg",
                    width: sW(context) / 1.5,
                  ),
                ],
              ),
            ),
            expandedHeight: 200,
            backgroundColor: Colors.white,
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                switch (state) {
                  case Loading _:
                    return loading(clr: Config.greenClr);

                  case Error e:
                    return error(
                      e.error,
                      onPressed: () => context.read<HomeCubit>().fetch(),
                    );
                  case Loaded ld:
                    return body(ld.spaces);

                  default:
                    return loading(clr: Config.greenClr);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget body(List<SpaceEntity> spaces) {
    return ListView(
      padding: EdgeInsetsDirectional.all(10),
      shrinkWrap: true,
      physics: const ScrollPhysics(),

      children: [
        Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,

              spacing: 5,
              children: [
                const Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Config.baseClr,
                  ),
                ),
                Container(
                  height: 2,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Config.greenClr,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          ],
        ),

        ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: spaces.length,
          itemBuilder: (context, index) {
            var data = spaces[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  navigatorKey.currentState!.pushNamed(
                    "/detail",
                    arguments: data.id,
                  );
                },
                child: Container(
                  height: 250,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 2,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 170,
                                viewportFraction: 1.0,
                                autoPlay: false,
                                onPageChanged: (imageIndex, reason) {
                                  context.read<SliderCubit>().changeIndex(
                                    index,
                                    imageIndex,
                                  );
                                },
                              ),
                              items: data.images.map((imgPath) {
                                return Image.asset(
                                  "assets/images/$imgPath",
                                  width: sW(context),
                                  fit: BoxFit.cover,
                                );
                              }).toList(),
                            ),
                          ),

                          BlocBuilder<SliderCubit, Map<int, int>>(
                            builder: (context, state) {
                              int currentIndex = context
                                  .read<SliderCubit>()
                                  .getIndex(index);
                              return Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: data.images.asMap().entries.map((
                                    entry,
                                  ) {
                                    return Container(
                                      width: 6.0,
                                      height: 6.0,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 3.0,
                                        vertical: 6.0,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: currentIndex == entry.key
                                            ? Config.greenClr
                                            : Config.greyClr,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            },
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
                                "${data.pricePerHour}/hour",
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),

                                Row(
                                  spacing: 5,
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Config.greenClr,
                                      ),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                    Text(
                                      data.rating,
                                      style: TextStyle(color: Config.greyClr),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 5,
                              children: [
                                Expanded(
                                  child: Text(
                                    data.location,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Config.greyClr),
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
        ),
      ],
    );
  }

  Drawer drawer() => Drawer(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    child: SafeArea(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/build.jpg", width: sW(context) / 4),
                RichText(
                  text: TextSpan(
                    text: "CO-SPACE ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Config.baseClr,
                    ),
                    children: [
                      TextSpan(
                        text: ".",
                        style: TextStyle(
                          color: Config.greenClr,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          spaceHeight(5),
          tile(
            onTap: () {
              navigatorKey.currentState!.popAndPushNamed("/booking");
            },
            title: "My Bookings",
            ic: CupertinoIcons.bookmark,
          ),

          tile(
            onTap: () {
            
            },
            title: "Notifications",
            ic: CupertinoIcons.bell,
          ),
        ],
      ),
    ),
  );

  ListTile tile({
    Function()? onTap,
    required String title,
    required IconData ic,
    isRed = false,
  }) {
    return ListTile(
      dense: true,
      onTap: onTap,
      leading: Icon(ic, size: 20, color: isRed ? Colors.red : null),
      trailing: isRed
          ? null
          : const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
              size: 12,
            ),
      title: Text(
        title,
        style: TextStyle(
          color: isRed ? Colors.red : Config.baseClr,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }
}
