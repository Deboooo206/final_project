import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/screen/ueser/Rating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class maintenance_information extends StatelessWidget {
  var Search;
  maintenance_information({this.Search});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(
              height: size.height * .01,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('user_App').
                where("Fix",isEqualTo:true).where("Area",isEqualTo:Search).snapshots(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount:snapshot.data!.docs.length ,
                        itemBuilder:(context, i){
                          // var products;
                          return Listmaintenance(
                            user_App:snapshot.data!.docs[i],
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

class Listmaintenance extends StatelessWidget {

  var user_App;
  var docid;



  Listmaintenance({this.user_App, this.docid});
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
                    builder: (context) => Rating(docid:docid,user_App:user_App,),)
              );
            },
            child: Container(
                width: size.width*.9,
                height: size.height*.11,
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
                        backgroundImage: NetworkImage("${user_App['imageurl']}"
                          ,),
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

                          child: Text("${user_App['Name']}",
                            maxLines: 1,
                            textScaleFactor:.85,
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

                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: size.width * .01,
                                ),
                              ),

                              Icon(
                                Icons.emoji_emotions,
                                color: Colors.grey.shade400,
                                size: 24.0,
                              ),
                              SizedBox(
                                width: size.width * .02,
                              ),
                              Text(
                                  "${user_App['good']}", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,
                                fontFamily: second_font,

                              )
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: size.width * .01,
                                ),
                              ),

                              Icon(
                                Icons.mood_bad,
                                color: Colors.grey.shade400,
                                size: 24.0,
                              ),
                              SizedBox(
                                width: size.width * .02,
                              ),
                              Text(
                                  "${user_App['bad']}", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,
                                fontFamily: second_font,

                              )
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: size.width * .01,
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
          SizedBox(
            height: size.height * .01,
          ),
        ],

      ),
    );
  }
}
