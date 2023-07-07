import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/screen/seller/edit_Products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';
import 'final_chat.dart';

class the_final_form extends StatefulWidget {
  final docid;
  final list;
  const the_final_form( {Key? key, this.docid, this.list}) : super(key: key);


  @override
  State<the_final_form> createState() => _the_final_formState();
}

class _the_final_formState extends State<the_final_form> {
  bool favorite=false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var uid_seller=widget.list['uid'];
    var imageurl_of_shop=widget.list['imageurl_of_shop'];
    var Name_of_shop=widget.list['Name_of_shop'];
    var Name_of_product=widget.list['Name'];
    var Price_of_product=widget.list['Price'];
    var view=widget.list['view'];
    var Favorite=widget.list['Favorite'];
    var chat=widget.list['chat'];
    //view++;
    //
    // Future<void> initState() async {
    //   super.initState();
    //   setState(() {
    //     view++;
    //   });
    //
    //   await FirebaseFirestore.instance.collection('products').doc(uid_seller).update(
    //       {
    //         "view": view,
    //       });
    //
    // }


    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => final_chat(
                    uid_seller: uid_seller,
                    Name_of_seller:Name_of_shop,
                    imageurl_of_seller:imageurl_of_shop,
                    Name_of_product:Name_of_product,
                    Price_of_product:Price_of_product,

                )));

          setState(() {
          chat++;
          });
          await FirebaseFirestore.instance.collection('products').doc(widget.docid).update(
              {
                "chat": chat,
              });
        },
        child: Icon(
          Icons.chat,
        ),
        backgroundColor: main_color,

      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              height: size.height*0.3,
              width: size.width*1,
              child:
              Column(
                children: [
                  Center(
                    child: Image(
                      image: NetworkImage(widget.list['imageurl']),
                      height: size.height*0.3,
                      width: size.width*1,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),

            ),
            SizedBox(
              height: size.height*.01,
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width*.05,
                ),
                Container(
                  width: size.width*.75,
                  height: size.height*.035,

                  child: Text(widget.list['Name'],
                    maxLines: 1,
                    textScaleFactor:.85,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(

                      fontSize:size.width*.06,
                      fontFamily: main_font,
                      fontWeight: FontWeight.bold,
                      color: second_color,
                    ),),
                ),
                Expanded(
                  child: SizedBox(
                    width: size.width*.05,
                  ),
                ),
                IconButton(onPressed: () async {

                  await FirebaseFirestore.instance.collection('Favorite').doc().set(
                      {
                        "Name": widget.list['Name'],
                        "Price": widget.list['Price'],
                        "description":widget.list['description'],
                        "condition":widget.list['condition'],
                        "imageurl": widget.list['imageurl'],
                        "uid":FirebaseAuth.instance.currentUser!.uid,
                        "Name_of_shop": widget.list['Name_of_shop'],
                        "imageurl_of_shop": imageurl_of_shop,
                        //"Area_of_shop": Area_of_shop,
                        "Address_of_shop": widget.list['Address_of_shop'],
                        "Phone_of_shop": widget.list['Phone_of_shop'],
                        "longitude":widget.list['longitude'],
                        "latitude":widget.list['latitude'],
                        "Favorite":widget.list['Favorite'],
                        "chat":widget.list['chat'],
                        "view":widget.list['view'],
                        //"time":FieldValue.serverTimestamp(),

                      });

                    setState(() {
                        favorite=!favorite;
                        Favorite++;

                    });


                  await FirebaseFirestore.instance.collection('products').doc(widget.docid).update(
                      {
                        "Favorite": Favorite,
                      });

                },icon: Icon(
                  Icons.favorite,
                  color: favorite?second_color:Colors.grey.shade400,
                  size: size.width*.08,
                ),),
                SizedBox(
                  width: size.width*.05,
                ),
              ],
            ),
            // SizedBox(
            //   height: size.height*.01,
            // ),
            Center(
              child: Container(
                height:size.width*.003,
                width: size.width*.9,
                color: Colors.grey.shade400,
              ),
            ),
            SizedBox(
              height: size.height*.01,
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width*.05,
                ),
                Text(widget.list['Price']
                  , style: TextStyle(
                  fontSize: size.width * .06,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                  fontFamily: second_font,

                ),),
                Expanded(
                  child: SizedBox(
                    width: size.width*.05,
                  ),
                ),

                Text(widget.list['condition']
                  , style: TextStyle(
                  fontSize: size.width * .06,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                  fontFamily: second_font,

                ),),
                SizedBox(
                  width: size.width*.05,
                ),

              ],
            ),
            SizedBox(
              height: size.height*.01,
            ),
            Center(
              child: Container(
                height:size.width*.003,
                width: size.width*.9,
                color: Colors.grey.shade400,
              ),
            ),
            SizedBox(
              height: size.height*.01,
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width*.05,
                ),
                Container(
                  width: size.width*.89,
                  height: size.height*.07,
                  child: Center(
                    child: Text(widget.list['Address_of_shop'] ,
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
                SizedBox(
                  width: size.width*.05,
                ),
              ],
            ),
            SizedBox(
              height: size.height*.01,
            ),
            Center(
              child: Container(
                height:size.width*.003,
                width: size.width*.9,
                color: Colors.grey.shade400,
              ),
            ),
            SizedBox(
              height: size.height*.01,
            ),
            Row(
              children: [
                SizedBox(
                width: size.width*.05,
              ),
                Text(widget.list['Phone_of_shop'],
                  style: TextStyle(
                  fontSize: size.width * .06,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                  fontFamily: second_font,

                ),),
                Expanded(
                  child: SizedBox(
                    width: size.width*.05,
                  ),
                ),

                IconButton(onPressed: () async {
                  String maplocationurl="https://www.google.com/maps/search/?api=1&query=${widget.list['latitude']},${widget.list['longitude']}";
                  String encodeurl=Uri.encodeFull(maplocationurl);
                  if(await canLaunch(encodeurl) ){
                  await launch(encodeurl);
                  }else{
                    //throw 'Could not launch $encodeurl';
                  }
                },
                  icon: Icon(
                    Icons.add_location,
                    color: Colors.grey.shade400,
                    size: size.width*.1,
                  ),),
                SizedBox(
                  width: size.width*.05,
                ),
              ],
            ),
            SizedBox(
              height: size.height*.01,
            ),
            // Center(
            //   child: Container(
            //     height:size.width*.003,
            //     width: size.width*.9,
            //     color: Colors.grey.shade400,
            //   ),
            // ),
            SizedBox(
              height: size.height*.01,
            ),
            Center(
              child: Container(
                  width: size.width*.9,
                  height: size.height*.17,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:Border.all(color: Colors.grey.shade400,)
              ),child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Text(widget.list['description'],
                    textAlign:TextAlign.right,
                    style: TextStyle(
                      fontFamily: second_font,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),



              ),
            ),
          ],
        ),
      ),
    );
  }
}
