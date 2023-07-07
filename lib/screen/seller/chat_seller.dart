import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/send_message2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../send_message.dart';

class chat_seller extends StatefulWidget {

  @override
  State<chat_seller> createState() => _chat_sellerState();
}

class _chat_sellerState extends State<chat_seller> {


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(
              height: size.height * .01,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('chat').
                where("to",isEqualTo: FirebaseAuth.instance.currentUser!.uid).
                where("number",isEqualTo:1).
                snapshots(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount:snapshot.data!.docs.length ,
                        itemBuilder:(context, i){
                          // var products;
                          return Listchat(
                            chat_seller:snapshot.data!.docs[i],
                              docid:snapshot.data!.docs[i].id

                          );
                        } ,
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator(color: main_color),);
                }),





          ],
        ),
      ),

    );
  }
}
class Listchat extends StatelessWidget {

  var chat_seller;
  var docid;



  Listchat({this.chat_seller,this.docid});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => send_message2(
                          //to:FirebaseAuth.instance.currentUser!.uid
                          from:chat_seller['from'],
                          name:chat_seller['Name_client'],
                          Name_of_product:chat_seller['Name_of_product'],
                          Price_of_product:chat_seller['Price_of_product'],

                      )));
            },
            child: Center(
              child: Container(
                  width: size.width*.9,
                  height: size.height*.1,
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color: Colors.white,
                      border:Border.all(color: Colors.grey.shade400,)
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width*.045,
                      ),
                      Container(
                        width: size.width*.15,
                        child: CircleAvatar(
                          radius: size.width*.075,
                          backgroundColor: second_color,
                          backgroundImage: NetworkImage("${chat_seller['photo_client']}"),

                        ),
                      ),
                      SizedBox(
                        width: size.width*.045,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SizedBox(
                            height: size.height*.009,
                          ),
                          Container(
                            width: size.width*.65,
                            height: size.height*.029,

                            child: Text("${chat_seller['Name_client']}",
                              textScaleFactor:.85,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(

                                fontSize:size.width*.05,
                                fontFamily: main_font,
                                fontWeight: FontWeight.bold,
                                color: second_color,
                              ),),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: size.height*.005,

                            ),
                          ),
                          Container(
                            width: size.width*.65,
                            height: size.height*.059,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: size.height*.005,

                                  ),
                                ),
                                Text("${chat_seller['Name_of_product']}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textScaleFactor:.85 ,
                                    style: TextStyle(
                                      fontSize:size.width*.05,
                                      fontFamily: main_font,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400,


                                    )),
                                Expanded(
                                  child: SizedBox(
                                    height: size.height*.005,

                                  ),
                                ),
                                Text("${chat_seller['Price_of_product']}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textScaleFactor:.85 ,
                                    style: TextStyle(
                                      fontSize:size.width*.05,
                                      fontFamily: main_font,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400,


                                    )),
                                Expanded(
                                  child: SizedBox(
                                    height: size.height*.005,

                                  ),
                                ),


                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: size.height*.005,

                            ),
                          ),
                        ],
                      ),

                    ],
                  )
              ),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
        ],

      ),
    );
  }
}
