import 'package:flutter/material.dart';
//import 'package:my_house/ui/shared/globals.dart';

class DateWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

   DateWidget({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      //cursorColor: Global.mediumBlue,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime(DateTime.now().year + 1))
            .then((value) => controller.text =
                '${value!.day.toString()}/${value.month.toString()}/${value.year.toString()}');
      },
      style: TextStyle(
       // color: Global.mediumBlue,
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        //labelStyle: TextStyle(color: Global.mediumBlue),
        //focusColor: Global.mediumBlue,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          //borderSide: BorderSide(color: Global.mediumBlue),
        ),
        labelText: hintText == null ? "DD/MM/YYYY" : hintText,
        prefixIcon: Icon(
          Icons.calendar_today_outlined,
          size: 18,
          //color: Global.mediumBlue,
        ),
      ),
    );
  }

   
}