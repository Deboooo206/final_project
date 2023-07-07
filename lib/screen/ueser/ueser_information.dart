import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/screen/ueser/edit_ueser_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../constant.dart';

class ueser_information extends StatefulWidget {

  @override
  State<ueser_information> createState() => _ueser_informationState();
}

class _ueser_informationState extends State<ueser_information> {
  @override

  var name,Phone,imageurl;
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
                builder: (context) => edit_ueser_information(
                   name:name,
                   Phone:Phone,
                   imageurl:imageurl,
                  // Fix:Fix,
                ),)
          );
        },
        child: Icon(
          Icons.edit,
        ), backgroundColor: main_color,

      ),
      appBar: AppBar(),
      body: ModalProgressHUD(

        inAsyncCall: wait,
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height*.07,
              ),
              CircleAvatar(
                  radius: size.width*.25,
                  backgroundColor: second_color,
                  backgroundImage:NetworkImage("${imageurl}")
              ),
              SizedBox(
                height: size.height*.05,
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
        imageurl=value.get("imageurl");
      });

    } );
    setState(() {
      wait=false;
    });
  }
}
