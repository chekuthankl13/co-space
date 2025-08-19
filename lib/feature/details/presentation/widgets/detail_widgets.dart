import 'package:co_workspace/core/config/config.dart';
import 'package:co_workspace/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailWidgets {
  ElevatedButton normal({
    required size,
    required txt,
    required onPressed,
    color = Config.greenClr,
    fcolor = Colors.white,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: size,
        foregroundColor: fcolor,
        backgroundColor: color,
      ),
      child: Text(txt, style: const TextStyle(fontSize: 17)),
    );
  }

  ElevatedButton normaliC({
    required size,
    required txt,
    required ic,
    required onPressed,
    color = Config.greenClr,
    fcolor = Colors.white,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: size,
        foregroundColor: fcolor,
        backgroundColor: color,
      ),
      icon: ic,
      label: Text(txt, style: const TextStyle(fontSize: 17)),
    );
  }

  TextButton text({required txt, required onPressed, color = Colors.red}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: color),
      child: Text(txt, style: const TextStyle(fontSize: 17)),
    );
  }

  ///////////////////////////////

  Expanded tile({required title, required ic}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(ic, size: 15),
          spaceHeight(5),
          Text(title, style: const TextStyle(fontSize: 11)),
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

  /////////////////////

  Column field({
    required txt,
    required cntr,
    ic,
    isReq = true,
    isRead = true,
    isNum = false,
    isTrail = false,
    isAddress = false,
    isIc = true,
    ontap,
    onChange,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        spaceHeight(5),
        Text(txt, style: TextStyle(fontSize: 15, color: Config.baseClr)),
        spaceHeight(5),
        TextFormField(
          controller: cntr,
          autocorrect: true,
          // autovalidateMode: AutovalidateMode.onUnfocus,
          onTap: ontap,
          readOnly: isRead,

          maxLines: isAddress ? 3 : 1,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          keyboardType: isNum ? TextInputType.number : TextInputType.text,
          validator: isReq
              ? (val) {
                  if (val!.isEmpty) {
                    return "*required !!";
                  } else {
                    return null;
                  }
                }
              : null,
          onChanged: onChange,
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: isIc ? Icon(ic, color: Colors.grey) : null,
            suffixIcon: isTrail
                ? Icon(Icons.arrow_drop_down, color: Colors.grey)
                : null,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Config.grey2Clr),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Config.grey2Clr),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Config.grey2Clr),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Config.grey2Clr),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Config.baseClr),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        spaceHeight(5),
      ],
    );
  }

  ///////////////////////////
  Future date(
    context, {
    required TextEditingController cntr,
    firstdate,
    lastdate,
  }) async {
    var pickeddate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstdate,
      lastDate: lastdate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Config.greenClr,
              onPrimary: Config.grey2Clr,
              onSurface: Config.baseClr,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickeddate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickeddate);
      cntr.text = formattedDate;
    }
  }
}
