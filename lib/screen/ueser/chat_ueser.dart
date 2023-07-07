import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/send_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class chat_ueser extends StatelessWidget {

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
                where("from",isEqualTo: FirebaseAuth.instance.currentUser!.uid).
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
                              chat_client:snapshot.data!.docs[i],
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

  var chat_client;
  var docid;



  Listchat({this.chat_client,this.docid});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap:(){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => send_message(
                          to:chat_client['to'],
                          name:chat_client['name_seller'],
                          Name_of_product:chat_client['Name_of_product'],
                          Price_of_product:chat_client['Price_of_product'],
                      )));
            } ,
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
                          backgroundImage: NetworkImage("${chat_client['photo_seller']}"),

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

                            child: Text("${chat_client['name_seller']}",
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
                                Text("${chat_client['Name_of_product']}",
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
                                Text("${chat_client['Price_of_product']}",
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
// Center(
// child: Container(
// width: size.width*.9,
// height: size.height*.1,
// decoration: BoxDecoration(
// borderRadius:BorderRadius.circular(10),
// color: Colors.white,
// border:Border.all(color: Colors.grey.shade400,)
// ),
// child: Row(
// children: [
// SizedBox(
// width: size.width*.045,
// ),
// Container(
// width: size.width*.15,
// child: CircleAvatar(
// radius: size.width*.075,
// backgroundImage: AssetImage('images/a.jpg'),
//
// ),
// ),
// SizedBox(
// width: size.width*.045,
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
//
// children: [
// SizedBox(
// height: size.height*.009,
// ),
// Container(
// width: size.width*.65,
// height: size.height*.029,
//
// child: Text('Name of shop',
// maxLines: 1,
// textScaleFactor:.85,
// overflow: TextOverflow.ellipsis,
// style: TextStyle(
//
// fontSize:size.width*.05,
// fontFamily: main_font,
// fontWeight: FontWeight.bold,
// color: second_color,
// ),),
// ),
// Expanded(
// child: SizedBox(
// height: size.height*.005,
//
// ),
// ),
// Container(
// width: size.width*.65,
// height: size.height*.059,
//
// child: Center(
// child: Text(' What is the price of iPhone 12 Pro ',
// maxLines: 2,
// overflow: TextOverflow.ellipsis,
// textScaleFactor:.85 ,
// style: TextStyle(
// fontSize:size.width*.04,
// fontFamily: second_font,
// fontWeight: FontWeight.bold,
// color: Colors.grey.shade400,
//
//
// )),
// ),
// ),
// Expanded(
// child: SizedBox(
// height: size.height*.005,
//
// ),
// ),
// ],
// ),
//
// ],
// )
// ),
// ),