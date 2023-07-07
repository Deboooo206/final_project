import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/screen/login_screen.dart';
import 'package:new_agraa_project/screen/ueser/bottom_Navigation_Bar_ueser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../components.dart';
import '../constant.dart';

class account_client extends StatefulWidget {

  @override
  State<account_client> createState() => _account_clientState();
}

class _account_clientState extends State<account_client> {
  var NameController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var imageurl;

  late File file;

  late Reference ref;
  bool photo_products=true;


  void initState() {
    super.initState();
    setState(() {
      try{
      file = File('images/photo.png');
          }catch(e){
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var z;

    setState(() {
      photo_products?z=AssetImage('images/photo.png'):z=FileImage( file,);
      if(file!=null){
        photo_products=false;
      }
    }
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: (){

              showModalBottomSheet<void>(
               context: context,
                builder: (BuildContext context) {
               return Container(
                 height: size.height*.15,
                child: Row(
                 children: [
                   SizedBox(
                     width: size.width*.05,
                   ),
                  GestureDetector(
                    onTap: () async {
                    var picked = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    if (picked != null) {
                      file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("file")
                          .child("$imagename");

                      //await ref.putFile(file);
                      //imageurl= await ref.getDownloadURL();

                      Navigator.of(context).pop();
                    }
                  },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera,
                          color: Colors.grey.shade400,
                          size: size.height*.085,
                        ),
                        Text('Camera', style: TextStyle(
                          color: Colors.grey.shade400,
                          fontFamily: main_font,
                        ))

                      ],
                    ),
                  ),
                   SizedBox(
                     width: size.width*.05,
                   ),
                   GestureDetector(
                     onTap: () async {
                       var picked = await ImagePicker()
                           .getImage(source: ImageSource.gallery);
                       if (picked != null) {
                         file = File(picked.path);
                         var rand = Random().nextInt(100000);
                         var imagename = "$rand" + basename(picked.path);
                         ref = FirebaseStorage.instance
                             .ref("file")
                             .child("$imagename");
                        // await ref.putFile(file);
                         //imageurl= await ref.getDownloadURL();


                         Navigator.of(context).pop();
                       }
                     },
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(
                           Icons.photo,
                           color: Colors.grey.shade400,
                           size: size.height*.085,
                         ),
                         Text('Gallery', style: TextStyle(
                           color: Colors.grey.shade400,
                           fontFamily: main_font,
                         ))

                       ],
                     ),
                   ),

                 ],
                  )
               );
                });




                },
                child: Container(
                  // height: size.height*.2,
                  // width: size.width*.4,
                  child: CircleAvatar(
                    radius: size.width*.25,
                    backgroundColor: second_color,
                    backgroundImage:z,
                    // backgroundImage:file == null ? null : FileImage(file),
                  ),
                ),
              ),
              SizedBox(
                height: size.height*.02,
              ),
              Center(
                child: defaultTextFormField2(
                  width: size.width*.8,
                  text: 'Name',
                  controller: NameController,
                  validate: ( value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Please enter the name';
                    }

                    return null;
                  },

                ),
              ),

              SizedBox(
                height: size.height*.02,
              ),
              Center(
                child: defaultTextFormField2(
                  width: size.width*.8,
                  text: 'phone',
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  validate: ( value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Please enter the phone';
                    }

                    return null;
                  },
                ),
              ),


              SizedBox(
                height: size.height*.02,
              ),
              defaultButton(
                text: 'Save',
                width: size.width*.6,
                height:size.height*0.055,
                function:() async {
                  if(formKey.currentState!.validate()) {
                    try {
                      // if( imageurl==null){
                      //   AwesomeDialog(
                      //     context: context,
                      //     dialogType: DialogType.ERROR,
                      //     // headerAnimationLoop: false,
                      //     //animType: AnimType.BOTTOMSLIDE,
                      //     title: ' ',
                      //     desc: 'entered the picture ',
                      //     buttonsTextStyle: TextStyle(color: Colors.black),
                      //     // showCloseIcon: true,
                      //     btnOkColor: Color(0xFFd93e47),
                      //     btnOkOnPress: () {},
                      //   )..show();
                      // }

                      // FirebaseAuth.instance.
                      //FirebaseAuth.instance.currentUser!.uid
                      await ref.putFile(file);
                      imageurl = await ref.getDownloadURL();

                      await FirebaseFirestore.instance.collection('user_App').doc(
                          FirebaseAuth.instance.currentUser!.uid).update(
                          {
                            "Name": NameController.text,
                            "Phone": phoneController.text,
                            "imageurl": imageurl
                          });

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,

                        // headerAnimationLoop: false,
                        //animType: AnimType.BOTTOMSLIDE,
                        title: ' ',
                        desc: 'A verification email was sent to you, please go check your email',
                        buttonsTextStyle: TextStyle(color: Colors.black),
                        // showCloseIcon: true,
                        btnOkColor: Color(0xFF00ca71),
                        btnOkOnPress: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context) => login_screen(),), (route) => false);
                        },
                      )..show();

                    } catch (e){
                    if(imageurl==null){
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          // headerAnimationLoop: false,
                          //animType: AnimType.BOTTOMSLIDE,
                          title: ' ',
                          desc: 'entered the picture ',
                          buttonsTextStyle: TextStyle(color: Colors.black),
                          // showCloseIcon: true,
                          btnOkColor: Color(0xFFd93e47),
                          btnOkOnPress: () {},
                        )..show();
                    }
                    }
                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    //   builder: (context) => bottom_Navigation_Bar_ueser(),), (route) => false);
                  }
                } ,
              ),

            ],
          ),
        ),
      ),
    );


  }
}
