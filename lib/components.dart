


import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'constant.dart';


Widget defaultButton({
  required width,
  required height,
  required String text,
   Color background = main_color,
  required Function function,


})=>Container(

  width: width,
  height:height,

  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)),
    ),
      child: Text(text, style: const TextStyle(color: Colors.white)),

      onPressed:(){function();}),
);

Widget defaultTextFormField (
{

  required width,
  required height,
  required IconData prefix,
           IconData? suffix,
          bool isPassword = false,
  TextEditingController? controller,
          validate,
          Function? suffixPressed,



})=>Container(
  width:width ,
   //height: height,
  child:   TextFormField(
    validator: validate,
      controller: controller,
    obscureText:isPassword ,
      style:const TextStyle(color: main_color),
      cursorColor: main_color,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: second_color,
            ),
          ),
          enabledBorder: OutlineInputBorder(

              borderSide: const BorderSide(
                color: second_color,
              ),
              borderRadius: BorderRadius.circular(30)),

          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 2
            ),
            borderRadius: BorderRadius.circular(30),
          ) ,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.redAccent,
                width: 2
            ),
            borderRadius: BorderRadius.circular(30),
          ) ,

          prefixIcon: Icon(
            prefix,
            color:main_color,),

        suffixIcon: IconButton(
          onPressed:(){suffixPressed!();} ,
           icon: Icon(
            suffix,
            color:main_color,),
        )
      )

  ),
);

Widget defaultTextFormField2 (
    {
      required width ,
      required String text,
     // IconData? prefix =null,
      validate,
      TextEditingController? controller,
      keyboardType =TextInputType.emailAddress,
      initialValue,
      onChanged,
      onSaved


    })=>Container(
      width: width,
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        validator: validate,
        onSaved:onSaved,
        onChanged:onChanged ,
        keyboardType: keyboardType,
      style:const TextStyle(
      color:main_color,
    ),
    cursorColor: main_color,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),

      focusedBorder:const OutlineInputBorder(

        borderSide: BorderSide(

          color: main_color,
        ),
      ) ,
      floatingLabelStyle: const TextStyle(
        color: main_color,
      ),
      // prefixIcon: Icon(
      //   prefix,
      //   color:main_color,),

      labelText: text,
    ),
  ),
);
Widget defaultTextFormField3 (
    {
      required width ,
      required String text,
      TextEditingController? controller,
      IconData? prefix ,
      keyboardType =TextInputType.emailAddress,

    })=>Container(
  width: width,
  child: TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    style:const TextStyle(
      color:main_color,
    ),
    cursorColor: main_color,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),

      focusedBorder:const OutlineInputBorder(

        borderSide: BorderSide(

          color: main_color,
        ),
      ) ,
      floatingLabelStyle: const TextStyle(
        color: main_color,
      ),
      prefixIcon: Icon(
        prefix,
        color:main_color,),

      labelText: text,
    ),
  ),
);


showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Please Wait"),
          content: Container(
              height: 50, child: const Center(child: CircularProgressIndicator(
            color: main_color,
          ))),
        );
      });
}

