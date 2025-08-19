import 'package:co_workspace/core/config/config.dart';
import 'package:co_workspace/core/utils/utils.dart';
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
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text("Seacrh"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
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
                      hint: "Search by name / location",
                    ),
                  ),
                  IconButton.filled(
                    style: IconButton.styleFrom(backgroundColor: Colors.black),
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
            ],
          ),
        ),
      ),
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
      fontSize: 14,
      fontWeight: FontWeight.w500,
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
        borderSide: BorderSide(color: Config.greyClr),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Config.greyClr),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Config.greyClr),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Config.greyClr),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Config.greyClr),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
