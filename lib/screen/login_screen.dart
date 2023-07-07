import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/screen/seller/bottom_Navigation_Bar_seller.dart';
import 'package:new_agraa_project/screen/ueser/bottom_Navigation_Bar_ueser.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../components.dart';
import '../constant.dart';
import 'signup_screen.dart';


class login_screen extends StatefulWidget {

  @override
  State<login_screen> createState() => _login_screenState();
}


class _login_screenState extends State<login_screen> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword =true;
  var Type_of_user;

  // Future<void> getName() async {
  //   DocumentSnapshot<Map<String,dynamic>> ds =
  //   await FirebaseFirestore.instance.collection('client').doc(FirebaseAuth.instance.currentUser!.uid).get();
  //   getname = ds.data["user"];
  //
  // }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(

      backgroundColor: Colors.white,

      body: SingleChildScrollView(

        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('images/signup_top.png'),
                height:size.height*0.15 ,
              ),
              Center(
                child: Image(
                  image: AssetImage('images/undraw_Destination_re_sr74.png'),
                  width: size.width*1,
                  height:size.height*0.32 ,
                ),

              ),
              SizedBox(
                height: size.height*.02,
              ),
              Center(
                  child: defaultTextFormField(
                    prefix: Icons.person,
                    width: size.width*.8,
                    height:size.height*0.065,
                    controller: emailController,
                    validate: ( value)
                    {
                      if(value.isEmpty)
                      {
                        return 'email must not be empty';
                      }

                      return null;
                    },

                  )
              ),


              SizedBox(
                height: size.height*.02,
              ),
              Center(
                child: defaultTextFormField(
                  prefix: Icons.lock,
                  width: size.width*.8,
                  height:size.height*0.065,
                  suffix:isPassword?Icons.remove_red_eye:Icons.visibility_off,
                  isPassword: isPassword,
                  controller: passwordController,
                  suffixPressed: (){
                    setState(() {
                      isPassword=!isPassword;
                    });
                  },
                  validate: ( value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Password must not be empty';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(
                height: size.height*.02,
              ),
              Center(
                child: defaultButton(
                    width: size.width*.8,
                    height:size.height*0.065,
                    text: "LOGIN",
                    function: () async {

                      if(formKey.currentState!.validate()) {
                        try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                        var userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);

                        await   FirebaseFirestore.instance.collection('user_App').
                        doc(FirebaseAuth.instance.currentUser!.uid).
                        get().
                        then((value) {
                          Type_of_user =value.get("user");
                          // print(value.get("user"));
                        } );

                        if(userCredential.user?.emailVerified==false){
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            // headerAnimationLoop: false,
                            //animType: AnimType.BOTTOMSLIDE,
                            title: ' ',
                            desc: 'Your account was not verified yet, please go check your email',
                            buttonsTextStyle: TextStyle(color: Colors.black),
                            // showCloseIcon: true,
                            btnOkColor: Color(0xFFd93e47),
                            btnOkOnPress: () {},
                          )..show();
                        }else{
                          if(Type_of_user=="client"){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context) =>bottom_Navigation_Bar_ueser() ,), (route) => false);

                          }else if(Type_of_user=="owner"){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context) =>bottom_Navigation_Bar_seller() ,), (route) => false);

                          }

                        }


                        }on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              // headerAnimationLoop: false,
                              //animType: AnimType.BOTTOMSLIDE,
                              title: ' ',
                              desc: 'No user found for that email.',
                              buttonsTextStyle: TextStyle(color: Colors.black),
                              // showCloseIcon: true,
                              btnOkColor: Color(0xFFd93e47),
                              btnOkOnPress: () {},
                            )..show();
                          } else if (e.code == 'wrong-password') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              // headerAnimationLoop: false,
                              //animType: AnimType.BOTTOMSLIDE,
                              title: ' ',
                              desc: 'Wrong password provided for that user.',
                              buttonsTextStyle: TextStyle(color: Colors.black),
                              // showCloseIcon: true,
                              btnOkColor: Color(0xFFd93e47),
                              btnOkOnPress: () {},
                            )..show();
                          }
                        }
                      }
                    }),
              ),

              Container(
                height:size.height*0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context) =>signup_screen() ,), (route) => false);
                        },
                        child: Text(
                          'SIGNUP',style: TextStyle(
                          color:main_color,

                        ),))
                  ],
                ),
              ),
              SizedBox(
                height: size.height*.045,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  Image(

                    image: AssetImage('images/login_bottom.png'),
                    height:size.height*0.15 ,
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


