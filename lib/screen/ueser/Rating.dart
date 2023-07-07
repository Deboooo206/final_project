import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/screen/ueser/final_chat_maintenance.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';

class Rating extends StatefulWidget {
  final docid;
  final user_App;
  const Rating( {Key? key, this.docid, this.user_App}) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  bool good=false ;
  bool bad=false ;
  @override

  Widget build(BuildContext context) {
    int _good=widget.user_App['good'];
    int _bad=widget.user_App['bad'];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton:FloatingActionButton(
          onPressed: ()  {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => final_chat_maintenance(
                       uid_seller: widget.user_App['uid'],
                       Name_of_seller: widget.user_App['Name'],
                       imageurl_of_seller: widget.user_App['imageurl'],
                      // Name_of_product:Name_of_product,
                      // Price_of_product:Price_of_product,

                    )));
          },
          child: Icon(
            Icons.chat,
          ),
          backgroundColor: main_color,

        ),
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height*.25,

                child: Center(
                  child: CircleAvatar(
                      radius: size.width*.25,
                      backgroundColor: second_color,
                      backgroundImage:NetworkImage(widget.user_App['imageurl'])
                  ),
                ),
              ),
              SizedBox(
                height: size.height*.05,
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
                        child: Text(widget.user_App['Address'] ,
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
                height: size.height*.03,
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
                      child: Text(widget.user_App['Phone'],
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
                height: size.height*.03,
              ),
              IconButton(
                icon: Icon(
                  Icons.add_location ,
                  size: size.width *.15,
                  color:main_color,
                ),
                onPressed: () async {
                  String maplocationurl="https://www.google.com/maps/search/?api=1&query=${widget.user_App['latitude']},${widget.user_App['longitude']}";
                          String encodeurl=Uri.encodeFull(maplocationurl);
                          if(await canLaunch(encodeurl) ){
                          await launch(encodeurl);
                          }else{
                          //throw 'Could not launch $encodeurl';
                          }
                },
              ),
              SizedBox(
                height: size.height*.03,
              ),

              Row(
                 mainAxisAlignment: MainAxisAlignment.center,

                 children: [
                   IconButton(
                     icon: Icon(
                     Icons.emoji_emotions,
                     size: size.width *.15,
                     color:good? second_color:Colors.grey.shade400,

                     ),
                     onPressed: () async {
                       setState(() {
                         good=true;
                         bad=false;

                       });
                       if(good=true){
                         _good++;
                         await FirebaseFirestore.instance.collection('user_App').doc(widget.user_App['uid']).update(
                             {
                               "good": _good,
                             });
                       }

                     },),
                   SizedBox(
                     width: size.width*.2,
                   ),
                   IconButton(
                     icon: Icon(
                       Icons.mood_bad ,
                       size: size.width *.15,
                       color: bad? second_color:Colors.grey.shade400,
                     ),
                     onPressed: () async {
                       setState(() {
                         good=false;
                         bad=true;

                       });
                       if(bad=true){
                         _bad++;
                         await FirebaseFirestore.instance.collection('user_App').doc(widget.user_App['uid']).update(
                             {
                               "bad": _bad,
                             });
                       }

                   },
                   ),
                 ],
               ),
              //
              //  Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //    mainAxisAlignment: MainAxisAlignment.end,
              //
              //  children: [
              //      FloatingActionButton(
              //       onPressed: ()  async {
              //         String maplocationurl="https://www.google.com/maps/search/?api=1&query=${widget.user_App['latitude']},${widget.user_App['longitude']}";
              //         String encodeurl=Uri.encodeFull(maplocationurl);
              //         if(await canLaunch(encodeurl) ){
              //         await launch(encodeurl);
              //         }else{
              //         //throw 'Could not launch $encodeurl';
              //         }
              //       },
              //       child: Icon(
              //         Icons.add_location,
              //         size: size.width *.1,
              //       ),
              //       backgroundColor: main_color,
              //
              // ),
              //      SizedBox(
              //        height: size.height*.02,
              //      ),
              //
              //    ],
              //  ),






            ],
          ),
      ),
        ),
    );
  }
}
