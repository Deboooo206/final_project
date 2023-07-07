import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../components.dart';
import '../../constant.dart';

class edit_ueser_information extends StatefulWidget {

  var name,Phone;
  var imageurl;

  edit_ueser_information({this.name, this.Phone, this.imageurl});

  @override
  State<edit_ueser_information> createState() => _edit_ueser_informationState();
}

class _edit_ueser_informationState extends State<edit_ueser_information> {
  var formKey = GlobalKey<FormState>();

  late File file;
  var imageurl;
  var name,Phone;
  late Reference ref;

  bool photo=true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     var z;
    setState(() {
       z;
       photo?z=NetworkImage(widget.imageurl):z=FileImage(file,);
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

                                      if(file!=null){
                                        photo=false;
                                        await ref.putFile(file);
                                        imageurl = await ref.getDownloadURL();
                                      }
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
                                      if(file!=null){
                                        photo=false;
                                        await ref.putFile(file);
                                        imageurl = await ref.getDownloadURL();
                                      }

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
                  initialValue:widget.name,
                  text: 'Name',
                  onChanged: (value){
                    name=value;
                  },
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
                  initialValue:widget.Phone,

                  width: size.width*.8,
                  text: 'phone',
                  onChanged: (value){
                    Phone=value;
                  },
                  keyboardType: TextInputType.phone,
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

                      if(name!=null){
                        await FirebaseFirestore.instance.collection('user_App').doc(FirebaseAuth.instance.currentUser!.uid).update(
                            {
                              "Name": name,
                            });
                      }
                      if(Phone!=null){

                        await FirebaseFirestore.instance.collection('user_App').doc(FirebaseAuth.instance.currentUser!.uid).update(
                            {
                              "Phone": Phone,
                            });
                      }

                      if(imageurl!=null){

                        await FirebaseFirestore.instance.collection('user_App').doc(FirebaseAuth.instance.currentUser!.uid).update(
                            {
                              "imageurl": imageurl,
                            });
                      }

                    } catch (e){}
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
