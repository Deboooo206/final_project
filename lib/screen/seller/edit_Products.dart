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

class edit_Products extends StatefulWidget {
  final docid;
  final list;


  const edit_Products({Key? key, this.docid, this.list}) : super(key: key);

@override
  State<edit_Products> createState() => _edit_ProductsState();
}

class _edit_ProductsState extends State<edit_Products> {

  //var TitleController = TextEditingController();
  //var PriceController = TextEditingController();
  //var textareaController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  dynamic condition="New";
  var imageurl;
  late File products;
  late Reference ref;
  var Name,Price,description;
  bool photo_products=true;

  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //var description;

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
                                      if(products!=null){
                                        photo_products=false;
                                        await ref.putFile(products);
                                        imageurl = await ref.getDownloadURL();
                                      }
                                      Navigator.of(context).pop();
                                    }
                                   // if(products!=null){
                                   //   photo_products=false;
                                   // }
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
                                      products = File(picked.path);
                                      var rand = Random().nextInt(100000);
                                      var imagename = "$rand" + basename(picked.path);
                                      ref = FirebaseStorage.instance
                                          .ref("products")
                                          .child("$imagename");
                                      // await ref.putFile(file);
                                      //imageurl= await ref.getDownloadURL();

                                      if(products!=null){
                                        photo_products=false;
                                        await ref.putFile(products);
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
                  //color:  second_color,
                  height: size.height*.2,
                  width: size.width*.4,
                  child:photo_products? Image(image: NetworkImage(widget.list['imageurl']),):Image(image:FileImage( products,),)
                  // child: CircleAvatar(
                  //   radius: size.width*.25,
                  //   backgroundColor: second_color,
                  //   backgroundImage:NetworkImage(widget.list['imageurl']),
                  //
                  //   //backgroundImage:file == null ? null : FileImage(file),
                  //
                  // ),

                ),

              ),

              SizedBox(
                height: size.height*.03,
              ),
              Center(
                child: defaultTextFormField2(
                  initialValue:widget.list['Name'],
                  onChanged: (value){
                    Name=value;
                  },
                 // controller: TitleController,
                  width: size.width*.8,
                  text: 'Title',

                  // onSaved: (val) {
                  //   TitleController = val;
                  // },
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
                  onChanged: (value){
                    Price=value;
                  },
                  onSaved: (value){
                    Price=value;
                  },
                  initialValue:widget.list['Price'],
                  width: size.width*.8,
                  text: 'Price',
                  //controller: PriceController,
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
                    value: 'Uesd',
                    groupValue: condition,
                    onChanged: (value) {
                      setState(() {
                        condition = value;
                      });
                    },
                    activeColor: main_color,

                  ),
                  Text(
                    'Uesd', style: TextStyle(
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
                  initialValue:widget.list['description'],
                  //controller: textareaController,
                  onChanged:(value){
                    description=value;
                  },

                  // onSaved: (value){
                  //   description=value;
                  // },
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
                  setState(()  {
                    //imageurl =  ref.getDownloadURL();


                  });
                  if(formKey.currentState!.validate())
                  {
                    try {
                      // await ref.putFile(products);
                      // imageurl = await ref.getDownloadURL();

                      if(Name!=null){

                        await FirebaseFirestore.instance.collection('products').doc(widget.docid).update(
                            {
                              "Name": Name,
                            });
                      }
                      if(Price!=null){

                        await FirebaseFirestore.instance.collection('products').doc(widget.docid).update(
                            {
                              "Price": Price,
                            });
                      }
                      if(description!=null){

                        await FirebaseFirestore.instance.collection('products').doc(widget.docid).update(
                            {
                              "description": description,
                            });
                      }
                      if(imageurl!=null){

                        await FirebaseFirestore.instance.collection('products').doc(widget.docid).update(
                            {
                              "imageurl": imageurl,
                            });
                      }

                      await FirebaseFirestore.instance.collection('products').doc(widget.docid).update(
                          {
                            "condition":condition,
                          });
                    } catch (e){

                    }
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
}
