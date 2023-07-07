import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


import '../components.dart';
import '../constant.dart';
import 'account.dart';
import 'account_client.dart';

class signup_screen extends StatefulWidget {

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  dynamic _value ='client';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword =true;



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
                  image: AssetImage('images/undraw_location_review_dmxd.png'),
                  height:size.height*0.32 ,
                ),
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
                  },              ),
              ),
              SizedBox(
                height: size.height*.02,
              ),


              Container(
                height: size.height*.065,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: size.width*.02,
                      ),
                    ),
                    Radio(
                        value: 'client',
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      activeColor: main_color,

                    ),
                    Text(
                      'client', style: TextStyle(
                      fontFamily: main_font,
                      color: second_color,
                      fontSize: size.width*.06,
                    ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: size.width*.02,
                      ),
                    ),
                    Radio(

                      value: 'owner',
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                      activeColor: main_color,

                    ),
                    Text(
                      'owner', style: TextStyle(
                      fontFamily: main_font,
                      color: second_color,
                      fontSize: size.width*.06,
                    ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: size.width*.02,
                      ),
                    ),

                  ],
                ),
              ),

              // SizedBox(
              //   height: size.height*.065,
              // )


              Center(
                child: defaultButton(
                    width: size.width*.8,
                    height:size.height*0.065,
                    text: "SIGNUP",
                    function: ()   async {
                      print("entered");
                      if(formKey.currentState!.validate())
                      {
                        print("valid");
                        showLoading(context);
                        try {
                        final response =await FirebaseAuth.instance.createUserWithEmailAndPassword(
                             email: emailController.text, password: passwordController.text,);
                        print(response.user);
                        if(_value=="client"){
                          await FirebaseFirestore.instance.collection('user_App').doc(FirebaseAuth.instance.currentUser!.uid).set(
                              {
                                "email":emailController.text,
                                "user":_value,
                                "Password":passwordController.text,
                                "uid":FirebaseAuth.instance.currentUser!.uid
                              });
                        }else {
                          await FirebaseFirestore.instance.collection('user_App').doc(FirebaseAuth.instance.currentUser!.uid).set(
                              {
                                "email": emailController.text,
                                 "user":_value,
                                "Password": passwordController.text,
                                "uid":FirebaseAuth.instance.currentUser!.uid
                              });
                        }
                        var userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        print(userCredential);
                        if(_value=="client"){
                          final response = await FirebaseAuth.instance.currentUser?.sendEmailVerification();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context) => account_client(),), (route) => false);

                        }else{
                          await FirebaseAuth.instance.currentUser?.sendEmailVerification();

                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context) => account(),), (route) => false);
                        }
                       }catch (e){
                          print(e);
                         // if(e.code == 'email-already-in-use') {
                         //   AwesomeDialog(
                         //     context: context,
                         //     dialogType: DialogType.ERROR,
                         //    // headerAnimationLoop: false,
                         //     //animType: AnimType.BOTTOMSLIDE,
                         //    //title: ' ',
                         //     desc: 'The account already exists for that email ',
                         //     buttonsTextStyle: TextStyle(color: Colors.black),
                         //    // showCloseIcon: true,
                         //     btnOkColor: Color(0xFFd93e47),
                         //     btnOkOnPress: () {},
                         //   ).show();
                         // }
                      }

                      }

                    }),
              ),
              Container(
                height:size.height*0.06,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context) =>login_screen() ,), (route) => false);
                        },
                        child: Text(
                          'SIGN IN',style: TextStyle(
                          color: main_color,

                        ),))
                  ],
                ),
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

