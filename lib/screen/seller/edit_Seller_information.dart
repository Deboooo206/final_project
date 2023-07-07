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

class edit_Seller_information extends StatefulWidget {
  var name,Phone,Area,Address,imageurl,Fix;

  edit_Seller_information({this.name,this. Phone, this.Area,this.Address,this.imageurl,this. Fix,});

  @override
  State<edit_Seller_information> createState() => _edit_Seller_informationState();
}

class _edit_Seller_informationState extends State<edit_Seller_information> {
  //var Name,Phone,Area,Address,Fix;

  // var NameController = TextEditingController();
  // var AreaController = TextEditingController();
  // var AddressController = TextEditingController();
  // var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var imageurl;
  late File file;
  late Reference ref;
  var name,Phone,Area,Address,Fix;
  bool photo=true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var z;
    photo? z=NetworkImage(widget.imageurl):z=FileImage(file,);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
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
                child: CircleAvatar(
                  radius: size.width*.25,
                  backgroundColor: second_color,
                  backgroundImage:z
                  //NetworkImage(widget.imageurl),
                  //NetworkImage(widget.imageurl):FileImage( file,)
                ),
              ),
              SizedBox(
                height: size.height*.02,
              ),
              Center(
                child: defaultTextFormField2(
                  onChanged: (value){
                    name=value;
                  },

                  initialValue:widget.name,
                  width: size.width*.8,
                  text: 'Name',
                  //controller: NameController,
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
                  initialValue:widget.Area,
                  width: size.width*.8,
                  text: 'Area',
                  onChanged: (value){
                    Area=value;
                  },
                  //controller: AreaController,
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
                  initialValue:widget.Address,
                  width: size.width*.8,
                  text: 'Address',
                  onChanged: (value){
                    Address=value;
                  },
                  //controller: AddressController,
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
                  initialValue:widget.Phone,
                  width: size.width*.8,
                  text: 'phone',
                  onChanged: (value){
                    Phone=value;
                  },
                  keyboardType: TextInputType.phone,
                  //controller: phoneController,
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
                    value: widget.Fix,
                    onChanged: ( value) {
                      setState(() {
                        widget.Fix  = value!;
                      });
                    },
                    activeColor: main_color,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: size.width*.1,
                    ),
                  ),

                  IconButton(onPressed: (){},
                    icon: Icon(
                      Icons.add_location,
                      color: Colors.grey.shade400,
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



                  if(formKey.currentState!.validate()) {

                    try {


                      if(name!=null){
                        await FirebaseFirestore.instance.collection('user_App').doc(FirebaseAuth.instance.currentUser!.uid).update(
                            {
                              "Name": name,
                            });
                      }
                      if(Area!=null){

                        await FirebaseFirestore.instance.collection('user_App').doc(FirebaseAuth.instance.currentUser!.uid).update(
                        {
                          "Area": Area,
                        });
                       }
                      if(Address!=null){

                         await FirebaseFirestore.instance.collection('user_App').doc(FirebaseAuth.instance.currentUser!.uid).update(
                        {
                          "Address": Address,
                        });
                       }
                     if(Phone!=null){

                    await FirebaseFirestore.instance.collection('user_App').doc(FirebaseAuth.instance.currentUser!.uid).update(
                        {
                          "Phone": Phone,
                        });
                  }
                      await FirebaseFirestore.instance.collection('user_App').doc(FirebaseAuth.instance.currentUser!.uid).update(
                          {
                            "Fix": widget.Fix,
                          });


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
