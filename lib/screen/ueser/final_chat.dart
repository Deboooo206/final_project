import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class final_chat extends StatefulWidget {
  var uid_seller,Name_of_seller,imageurl_of_seller,Name_of_product,Price_of_product;

  final_chat({ this.uid_seller, this.Name_of_seller, this.imageurl_of_seller,this.Name_of_product,this.Price_of_product});

  @override
  State<final_chat> createState() => _final_chatState();
}

class _final_chatState extends State<final_chat> {
  var messageController = TextEditingController();
  var Name_client,photo_client;
  int number=1;
  void initState() {
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body:Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('chat').orderBy("time").
                where("from",isEqualTo: FirebaseAuth.instance.currentUser!.uid).
                where("to",isEqualTo:widget.uid_seller).
                where("Name_of_product",isEqualTo:widget.Name_of_product).
                where("Price_of_product",isEqualTo:widget.Price_of_product).
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
                              message:snapshot.data!.docs[i],
                              docid:snapshot.data!.docs[i].id

                          );
                        } ,
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator(color: main_color),);
                }),
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                color: main_color,
                height: 2,
              ),
              TextFormField(
                  controller: messageController,
                  style:TextStyle(color: main_color),
                  cursorColor: main_color,
                  decoration: InputDecoration(
                      hintText:'write your message here...' ,
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed:() async {

                          await FirebaseFirestore.instance.collection('chat').doc().set(
                              {
                                "message":messageController.text,
                                "number":number,
                                "to":widget.uid_seller,
                                "from":FirebaseAuth.instance.currentUser!.uid,
                                "name_seller":widget.Name_of_seller,
                                "photo_seller":widget.imageurl_of_seller,
                                "Name_client":Name_client,
                                "photo_client":photo_client,
                                "time":FieldValue.serverTimestamp(),
                                "uid":FirebaseAuth.instance.currentUser!.uid,
                                "Name_of_product":widget.Name_of_product,
                                "Price_of_product":widget.Price_of_product,


                              });
                          number++;
                          messageController.clear();

                        } ,
                        icon: Icon(
                          Icons.send,
                          color:main_color,),
                      )
                  )

              ),
            ],
          ),

          SizedBox(
            height: size.height*0.02,
          )


        ],
      ) ,
    );
  }
  getdata() async {

    await FirebaseFirestore.instance.collection('user_App').
    doc(FirebaseAuth.instance.currentUser!.uid).
    get().
    then((value) {
      Name_client =value.get("Name");
      photo_client =value.get("imageurl");

    });

  }
}
class Listchat extends StatelessWidget {

  var message;
  var docid;
  var UID=FirebaseAuth.instance.currentUser!.uid;
  bool ismy=true;




  Listchat({this.message,this.docid});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // if(message['uid']!=UID){
    //   ismy=false;
    // }
    if(message['uid']!=UID){
      ismy=false;
    }
    return Padding(

      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:ismy? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Container(
            decoration:ismy? BoxDecoration(
              borderRadius:BorderRadius.only(
                topLeft:Radius.circular(30),
                bottomLeft:Radius.circular(30),
                bottomRight:Radius.circular(30),
              ),
              color:second_color,
            ):BoxDecoration(
              borderRadius:BorderRadius.only(
                topRight:Radius.circular(30),
                bottomLeft:Radius.circular(30),
                bottomRight:Radius.circular(30),
              ),
              color:Colors.grey.shade400,
            ),

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${message['message']}",style: TextStyle(
                color: Colors.white,
                fontSize: size.width * .04,
                //fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
