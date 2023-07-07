import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class send_message2 extends StatelessWidget {

  var messageController = TextEditingController();
  var from,name,Name_of_product,Price_of_product;

  send_message2({this.from,this.name, this.Name_of_product, this.Price_of_product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:main_color,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("${name}"),

      ),
      body: Column(
        children: [

          SizedBox(
            height: size.height * .01,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('chat').orderBy("time").
                where("from",isEqualTo: from).
                where("to",isEqualTo:FirebaseAuth.instance.currentUser!.uid).
                where("Name_of_product",isEqualTo:Name_of_product).
                where("Price_of_product",isEqualTo:Price_of_product).
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
                        onPressed:()  async {

                          await FirebaseFirestore.instance.collection('chat').doc().set(
                              {
                                "message":messageController.text,
                                //"number":number,
                                "to":FirebaseAuth.instance.currentUser!.uid,
                                "from":from,
                                //"name_seller":widget.Name_of_seller,
                                //"photo_seller":widget.imageurl_of_seller,
                                //"Name_client":Name_client,
                                //"photo_client":photo_client,
                                "time":FieldValue.serverTimestamp(),
                                "uid":FirebaseAuth.instance.currentUser!.uid,
                                "Name_of_product":Name_of_product,
                                "Price_of_product":Price_of_product,

                              });
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
            height: size.height*0.01,
          )


        ],
      ),

    );
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
