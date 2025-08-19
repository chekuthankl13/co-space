import 'package:carousel_slider/carousel_slider.dart';
import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/core/config/config.dart';
import 'package:co_workspace/core/utils/utils.dart';
import 'package:co_workspace/feature/home/logic/slider_cubit.dart';
import 'package:co_workspace/feature/search/logic/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchCntr = TextEditingController();

  @override
  void dispose() {
    searchCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>navigatorKey.currentState!.pop(), icon: Icon(Icons.arrow_back_ios,size: 20,color: Config.greenClr,)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            spaceHeight(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: sW(context) / 1.2,
                  child: simple(
                    isDense: true,
                    cntr: searchCntr,
                    leadingIc: Icons.search,
                    hint: "search by name / location",
                  ),
                ),
                IconButton.filled(
                  style: IconButton.styleFrom(backgroundColor: Config.greenClr),
                  onPressed: () {
                    if (searchCntr.text.isNotEmpty) {
                      context.read<SearchCubit>().search(searchCntr.text);
                      FocusManager.instance.primaryFocus!.unfocus();
                    } else {
                      errorToast(context, msg: "please enter...");
                    }
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            spaceHeight(5),
            BlocBuilder<SearchCubit,SearchState>(builder: (context, state) {
              switch (state) {
                case Loading _:
                    return Column(
                      children: [
                        spaceHeight(10),
                        loading(),
                      ],
                    );
                  
                case Error e:
                 return error(e.error, onPressed: ()=> context.read<SearchCubit>().search(searchCntr.text));
                 case Loaded ld:
                 return item(ld.data);
                default:
                return empty();
              }
            },)
          ],
        ),
      ),
    );
  }

  Widget item(List<SpaceEntity> data) {
    return data.isEmpty?itemEmpty(context, "No co-work space found !!"):
    Expanded(
      child: GridView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: 3 / 2,
                    childAspectRatio: 1, //1/2
                    mainAxisExtent: 250,
                    crossAxisSpacing: 0, // 5,
                    mainAxisSpacing: 1,
                  ), 
        itemBuilder: (context, index) {
          var item = data[index];
          return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    navigatorKey.currentState!.pushNamed(
                      "/detail",
                      arguments: item.id,
                    );
                  },
                  child: Container(
                    
      
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 1,
                          // spreadRadius: 2,
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
                                items: item.images.map((imgPath) {
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
                                    children: item.images.asMap().entries.map((
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
                                              : Config.greenClr,
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
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "${item.pricePerHour}/hour",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                    item.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                              Row(
                                spacing: 5,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Config.greenClr,
                                    ),
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 8,
                                    ),
                                  ),
                                  Text(
                                    item.rating,
                                    style: TextStyle(color: Config.greyClr,fontSize: 12),
                                  ),
                                ],
                              ),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 5,
                                children: [
                                  Text(
                                    item.location,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Config.greyClr,fontSize: 10),
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
        },),
    );
  }
}

TextFormField simple({
  required cntr,
  required leadingIc,
  required hint,
  isRead = false,
  isReq = true,
  ispasw = false,
  isDense = false,
  isfilter = false,
  isnum = false,
  isTwoLine = false,
  suffix,
  obsure,
  ontap,
  onchange,
  trailIc,
  isLead = true,
}) {
  return TextFormField(
    controller: cntr,
    readOnly: isRead,
    maxLines: isTwoLine ? 2 : 1,
    onTap: isRead ? ontap : null,
    autocorrect: true,
    obscureText: ispasw ? obsure : false,
    keyboardType: isnum ? TextInputType.numberWithOptions() : null,
    validator: isReq
        ? (val) {
            if (val!.isEmpty) {
              return "*required !!";
            }
            return null;
          }
        : null,
    style: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    onChanged: onchange,
    decoration: InputDecoration(
      errorStyle: const TextStyle(color: Colors.grey),
      hintText: hint,
      hintStyle: isfilter ? const TextStyle(color: Colors.grey) : null,
      isDense: isDense,
      suffixIcon:
          suffix ??
          (trailIc != null ? Icon(trailIc, color: Colors.grey) : null),
      prefixIcon: isLead ? Icon(leadingIc, color: Colors.grey) : null,
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Config.greenClr),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Config.greenClr),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Config.greenClr),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Config.greenClr),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Config.greenClr),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
