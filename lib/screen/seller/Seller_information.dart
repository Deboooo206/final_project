import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../constant.dart';
import 'edit_Seller_information.dart';

class Seller_information  extends StatefulWidget {

  @override
  State<Seller_information> createState() => _Seller_informationState();
}

class _Seller_informationState extends State<Seller_information> {
  @override
  var name,Phone,Area,Address,imageurl,Fix;
  bool wait=false;
  void initState() {
    super.initState();
    getdata();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => edit_Seller_information(
                    name:name,
                    Phone:Phone,
                    Area:Area,
                    Address:Address,
                    imageurl:imageurl,
                    Fix:Fix,
                ),)
          );
        },
        child: Icon(
          Icons.edit,
        ), backgroundColor: main_color,

      ),

      body: ModalProgressHUD(
        inAsyncCall: wait,
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: size.width*.25,
                backgroundColor: second_color,
                backgroundImage:NetworkImage("${imageurl}")
              ),
              SizedBox(
                height: size.height*.02,
              ),
              Center(
                child: Container(
                    width: size.width*.9,
                    height: size.height*.05,
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(10),
                        color: Colors.white,
                        border:Border.all(color: Colors.grey.shade400,)
                    ),
                    child: Container(
                      width: size.width*.89,
                      height: size.height*.07,
                      child: Center(
                        child: Text("${name}",
                          textAlign:TextAlign.right,
                          maxLines: 1,
                          textScaleFactor:.85,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(

                            fontSize:size.width*.05,
                            fontFamily: second_font,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400,
                          ),),
                      ),
                    ),
                ),
              ),
              SizedBox(
                height: size.height*.02,
              ),
              Center(
                child: Container(
                  width: size.width*.9,
                  height: size.height*.05,
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color: Colors.white,
                      border:Border.all(color: Colors.grey.shade400,)
                  ),
                  child: Container(
                    width: size.width*.89,
                    height: size.height*.07,
                    child: Center(
                      child: Text("${Phone}",
                        textAlign:TextAlign.right,
                        maxLines: 1,
                        textScaleFactor:.85,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(

                          fontSize:size.width*.05,
                          fontFamily: second_font,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        ),),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height*.02,
              ),
              Center(
                child: Container(
                  width: size.width*.9,
                  height: size.height*.05,
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color: Colors.white,
                      border:Border.all(color: Colors.grey.shade400,)
                  ),
                  child: Container(
                    width: size.width*.89,
                    height: size.height*.07,
                    child: Center(
                      child: Text("${Area}",
                        textAlign:TextAlign.right,
                        maxLines: 1,
                        textScaleFactor:.85,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(

                          fontSize:size.width*.05,
                          fontFamily: second_font,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        ),),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height*.02,
              ),
              Center(
                child: Container(
                  width: size.width*.9,
                  height: size.height*.075,
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color: Colors.white,
                      border:Border.all(color: Colors.grey.shade400,)
                  ),
                  child:Center(
                    child: Container(
                      width: size.width*.89,
                      height: size.height*.07,
                      child: Center(
                        child: Text("${Address}" ,
                          textAlign:TextAlign.right,
                          maxLines: 2,
                          textScaleFactor:.85,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(

                            fontSize:size.width*.05,
                            fontFamily: second_font,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400,
                          ),),
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(
                height: size.height*.02,
              ),
              Icon(
                Icons.add,
                color: Colors.grey.shade400,
                size: size.width*.15,
              ),
              SizedBox(
                height: size.height*.02,
              ),
              Icon(
                Icons.add_location,
                color: second_color,
                size: size.width*.15,
              )




            ],
          ),
        ),
      ),
    );

  }
  getdata() async {
    setState(() {
      wait=true;
    });
    await FirebaseFirestore.instance.collection('user_App').
    doc(FirebaseAuth.instance.currentUser!.uid).
    get().
    then((value) {
      setState(() {
        name =value.get("Name");
        Phone =value.get("Phone");
        Area =value.get("Area");
        Address =value.get("Address");
        imageurl=value.get("imageurl");
        Fix=value.get("Fix");
        // latitude=value.get("latitude");
        // longitude=value.get("longitude");

      });

    } );
    setState(() {
      wait=false;
    });
    }
}
