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

class Enter_products extends StatefulWidget {
  const Enter_products({Key? key}) : super(key: key);

  @override
  State<Enter_products> createState() => _Enter_productsState();
}

class _Enter_productsState extends State<Enter_products> {
  var TitleController = TextEditingController();
  var PriceController = TextEditingController();
  var textareaController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  dynamic condition="New";
  var imageurl;

  late File products;
  late Reference ref;
  var Name_of_shop,imageurl_of_shop,Area_of_shop,Address_of_shop,Phone_of_shop,latitude,longitude;
  int view=0;
  int Favorite=0;
  int chat=0;
  bool photo_products=true;

  void initState() {
    super.initState();
    getdata();
    setState(() {
       var x=AssetImage('images/photo.png');
       // var y =FileImage( products,);
      products = File('images/photo.png');
      // products = File('images/photo.png');
      
    });
    // products = File('images/photo.png');
    // products ='' as File;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // var x=AssetImage('images/photo.png');
    // var xx=AssetImage('images/cr7.jpg');
    //var y=FileImage( products);
    // var z;
    // if( products=null){
    //   var y=AssetImage('images/photo.png');
    //   photo_products=true;
    // }
    // setState(() {
    //   photo_products?z=x:z=xx;
    // });
    var z;
    setState(() {

      photo_products?z=AssetImage('images/photo.png'):z=FileImage( products,);
      if(products!=null){
        photo_products=false;
      }

    });

    var picked;
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
                                      products = File(picked.path);
                                      var rand = Random().nextInt(100000);
                                      var imagename = "$rand" + basename(picked.path);
                                      ref = FirebaseStorage.instance
                                          .ref("products")
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
                                        .getImage(source: ImageSource.gallery,
                                      imageQuality: 50,
                                        maxHeight:  400,
                                        maxWidth: 400
                                    );
                                    if (picked != null) {
                                      products = File(picked.path);
                                      var rand = Random().nextInt(100000);
                                      var imagename = "$rand" + basename(picked.path);
                                      ref = FirebaseStorage.instance
                                          .ref("products")
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

                  //color:  second_color,
                  height: size.height*.2,
                  width: size.width*.4,

                    // child: Image(
                    //   image: FileImage( products),
                    // ),


                    child: CircleAvatar(
                        radius: size.width*.25,
                        backgroundColor: second_color,
                        backgroundImage:z,
                    )
                  // child:Image(image: z),

                  //  child: Image(
                  //   image: FileImage( products,),
                  //    // height: double.infinity,
                  //    // width: double.infinity,
                  // ),

                  // child:products==null? Image(
                  //   image: AssetImage('images/photo.png')):Image(
                  //      image: FileImage(File(products.path)),),

                  // child: Image(
                  //   image: FileImage(File(picked.path)),
                  // ),


                ),

              ),

              SizedBox(
                height: size.height*.03,
              ),
              Center(
                child: defaultTextFormField2(
                  width: size.width*.8,
                  text: 'Title',
                  controller: TitleController,

                  validate: ( value)
                  {
                    if(value.isEmpty)
                    {
                      return 'email must not be empty';
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(
                height: size.height*.03,
              ),
              Center(
                child: defaultTextFormField2(
                  width: size.width*.8,
                  text: 'Price',
                  controller: PriceController,
                  validate: ( value)
                  {
                    if(value.isEmpty)
                    {
                      return 'email must not be empty';
                    }

                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width*.1,
                  ),
                  Radio(
                    value: 'New',
                    groupValue: condition,
                    onChanged: (value) {
                      setState(() {
                        condition = value;
                      });
                    },
                    activeColor: main_color,

                  ),
                  Text(
                    'New', style: TextStyle(
                    fontFamily: main_font,
                    color: second_color,
                    fontSize: size.width*.06,
                  ),
                  )
                ],

              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width*.1,
                  ),
                  Radio(
                    value: 'Used',
                    groupValue: condition,
                    onChanged: (value) {
                      setState(() {
                        condition = value;
                      });
                    },
                    activeColor: main_color,

                  ),
                  Text(
                    'Used', style: TextStyle(
                    fontFamily: main_font,
                    color: second_color,
                    fontSize: size.width*.06,
                  ),
                  )
                ],

              ),
              SizedBox(
                height: size.height*.03,
              ),
              Container(
                width: size.width*.8,
                child: TextFormField(
                  controller: textareaController,
                  maxLines: 4,
                  style:TextStyle(
                    color:main_color,
                  ),
                  cursorColor: main_color,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    focusedBorder:OutlineInputBorder(

                      borderSide: BorderSide(

                        color: main_color,
                      ),
                    ) ,
                    floatingLabelStyle: TextStyle(
                      color: main_color,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height*.03,
              ),

              defaultButton(
                text: 'OK',
                width: size.width*.6,
                height:size.height*0.055,
                function:() async {
                if(formKey.currentState!.validate())
                {
                try {

                await ref.putFile(products);
                imageurl = await ref.getDownloadURL();

                await FirebaseFirestore.instance.collection('products').doc().set(
                {
                  "Name": TitleController.text,
                  "Price": PriceController.text,
                  "description":textareaController.text,
                  "condition":condition,
                  "imageurl": imageurl,
                  "uid":FirebaseAuth.instance.currentUser!.uid,
                  "Name_of_shop": Name_of_shop,
                  "imageurl_of_shop": imageurl_of_shop,
                  "Area_of_shop": Area_of_shop,
                  "Address_of_shop": Address_of_shop,
                  "Phone_of_shop": Phone_of_shop,
                  "longitude":longitude,
                  "latitude":latitude,
                  "Favorite":Favorite,
                  "chat":chat,
                  "view":view,
                  "time":FieldValue.serverTimestamp(),


                });

                } catch (e){}
                }
                Navigator.pop(context);

                } ,
              ),
            ],

          ),
        ),
      ),
    );
  }
  getdata() async {

    await FirebaseFirestore.instance.collection('user_App').
    doc(FirebaseAuth.instance.currentUser!.uid).
    get().
    then((value) {
      Name_of_shop =value.get("Name");
      imageurl_of_shop =value.get("imageurl");
      Area_of_shop =value.get("Area");
      Address_of_shop =value.get("Address");
      Phone_of_shop =value.get("Phone");
      longitude=value.get("longitude");
      latitude=value.get("latitude");



    });

  }
}
