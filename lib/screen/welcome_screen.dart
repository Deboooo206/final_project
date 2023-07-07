import 'package:new_agraa_project/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../components.dart';
import '../constant.dart';
import 'login_screen.dart';


class welcome_screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Image(
                image: AssetImage('images/main_top.png'),
                height:size.height*0.2 ,
              ),
              Image(
                image: AssetImage('images/undraw_Traveling_re_weve.png'),
                height:size.height*0.5 ,
                width: double.infinity,

              ),



              Center(
                child:
                defaultButton(
                    width: size.width*.8,
                    height:size.height*0.065,
                    text: "LOGIN",
                    function: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) =>login_screen() ,), (route) => false);
                }),

              ),
              SizedBox(
                height: size.height*.02,
              ),
              Center(
                child: defaultButton(
                    width: size.width*.8,
                    height:size.height*0.065,
                    background: second_color,
                    text: "SIGNUP",
                    function: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) =>signup_screen() ,), (route) => false);
                    }),
              ),
              SizedBox(
                height: size.height*.02,
              ),
              Image(
                image: AssetImage('images/main_bottom.png'),
                height:size.height*0.13 ,

              ),

            ]
        )
    );

  }
}

