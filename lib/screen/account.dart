import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/screen/login_screen.dart';
import 'package:new_agraa_project/screen/seller/bottom_Navigation_Bar_seller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import 'package:path/path.dart';

import '../components.dart';
import '../constant.dart';

class account extends StatefulWidget {

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  bool show =false;
  late bool GPS ;
  Location location=new Location();
  late PermissionStatus Permission;
  late LocationData LocationDataa;
  var NameController = TextEditingController();
  var AreaController = TextEditingController();
  var AddressController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var imageurl;
  late File file;
  late Reference ref;
  var longitude;
  var latitude;
  bool color_location=false;

  bool photo_products=true;


  void initState() {
    super.initState();
    setState(() {
      // var x=AssetImage('images/photo.png');
      try{
        file = File('images/photo.png');
      }catch(e){

      }
      // products = File('images/photo.png');

    });
    //file = File('images/photo.png');

    // file = File('images/photo.png');

    // file = File('images/photo.png');

    // products = File('images/photo.png');
    // products ='' as File;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var photo;

    setState(() {
      photo_products?photo=AssetImage('images/photo.png'):photo=FileImage( file,);
      if(file!=null){
        photo_products=false;
      }
    });


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
                child: CircleAvatar(
                  radius: size.width*.25,
                  backgroundColor: second_color,
                  backgroundImage:photo,

                  //backgroundImage:file == null ? null : FileImage(file),

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
                  text: 'Area',
                  controller: AreaController,
                  validate: ( value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Please enter the Area';
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
                  text: 'Address',
                  controller: AddressController,
                  validate: ( value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Please enter the Address';
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
              Row(
                children: [
                  SizedBox(
                    width: size.width*.1,
                  ),
                  Text(
                    'Fix', style: TextStyle(
                    fontFamily: main_font,
                    color: Colors.grey,
                    fontSize: size.width*.06,
                  ),
                  ),
                  Checkbox(
                    value: show,
                    onChanged: ( value) {
                      setState(() {
                        show  = value!;
                      });
                    },
                    activeColor: main_color,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: size.width*.1,
                    ),
                  ),

                  IconButton(onPressed: () async {
                  GPS = await location.serviceEnabled();
                  if(!GPS){
                    GPS = await location.requestService();
                    if(!GPS){
                      return;
                    }
                  }
                  Permission= await location.hasPermission();
                  if(Permission==PermissionStatus.denied){
                    Permission= await location.requestPermission();
                    if(Permission!=PermissionStatus.granted){
                      return;
                    }

                  }
                  LocationDataa=await location.getLocation();
                  longitude=LocationDataa.longitude;
                  latitude=LocationDataa.latitude;
                  setState(() {
                    if(longitude!=null){
                      color_location=true;
                    }
                  });
                  },

                    icon: Icon(
                      Icons.add_location,
                      color: color_location?second_color:Colors.grey.shade400,
                      size: size.width*.12,
                    ),),
                  SizedBox(
                    width: size.width*.15,
                  ),


                ],
              ),

              SizedBox(
                height: size.height*.02,
              ),
              defaultButton(
                text: 'Save',
                width: size.width*.6,
                height:size.height*0.055,
                function:() async {
                  if(longitude!=null) {
                    if (formKey.currentState!.validate()) {
                      try {
                        await ref.putFile(file);
                        imageurl = await ref.getDownloadURL();
                        if (longitude == null) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            desc: 'Entered the location ',
                            buttonsTextStyle: TextStyle(color: Colors.black),
                            // showCloseIcon: true,
                            btnOkColor: Color(0xFFd93e47),
                            btnOkOnPress: () {},
                          )
                            ..show();
                        }
                        await FirebaseFirestore.instance.collection('user_App')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update(
                            {
                              "Name": NameController.text,
                              "Area": AreaController.text,
                              "Address": AddressController.text,
                              "Phone": phoneController.text,
                              "imageurl": imageurl,
                              "Fix": show,
                              "longitude": longitude,
                              "latitude": latitude,
                              "good": 0,
                              "bad": 0,
                            });
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.SUCCES,
                          desc: 'A verification email was sent to you, please go check your email',
                          buttonsTextStyle: TextStyle(color: Colors.black),
                          btnOkColor: Color(0xFF00ca71),
                          btnOkOnPress: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context) => login_screen(),), (route) => false);
                          },
                        )..show();
                      } catch (e) {
                        if (imageurl == null) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            desc: 'Entered the picture ',
                            buttonsTextStyle: TextStyle(color: Colors.black),
                            btnOkColor: Color(0xFFd93e47),
                            btnOkOnPress: () {},
                          )
                            ..show();
                        }
                      }
                    }
                  }else{
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        desc: 'Entered the location ',
                        buttonsTextStyle: TextStyle(color: Colors.black),
                        btnOkColor: Color(0xFFd93e47),
                        btnOkOnPress: () {},
                      )..show();

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
