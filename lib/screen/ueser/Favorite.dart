import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/screen/ueser/the_final_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constant.dart';

class Favorite extends StatelessWidget {

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

                stream: FirebaseFirestore.instance.collection('Favorite').
                where("uid",isEqualTo:FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount:snapshot.data!.docs.length ,
                        itemBuilder:(context, i){
                          // var products;
                          return ListFavorite(
                              Favorite:snapshot.data!.docs[i],
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

class ListFavorite extends StatelessWidget {

  var Favorite;
  var docid;

  ListFavorite({this.Favorite, this.docid});
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => the_final_form(docid:docid,list:Favorite,),)
            );
          },
          child: Center(
            child: Container(
              width: size.width*.9,
              height: size.height*.15,
              decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10),

                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 6.0,
                      spreadRadius: 4,
                      offset: Offset(3.0, 3.0), //(x,y)

                    ),
                  ],
                  border:Border.all(color: Colors.grey.shade400,)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(9.5),
                          bottomStart: Radius.circular(9.5),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                        image: NetworkImage("${Favorite['imageurl']}",),
                        fit: BoxFit.cover,
                        height:size.height*0.15 ,
                        width: size.width*0.28,

                      ),

                    ),
                  ),
                  SizedBox(
                    width: size.width*.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: size.height*.012,
                        ),
                      ),
                      Container(
                        width: size.width*0.59,

                        child: Text("${Favorite['Name_of_shop']}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: main_font,
                            fontWeight: FontWeight.bold,
                            color: second_color,
                          ),),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: size.height*.012,
                        ),
                      ),
                      Container(
                        width: size.width*0.59,
                        child: Text("${Favorite['Name']}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 20,

                              fontFamily: second_font,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,

                            )),
                      ),
                      // SizedBox(
                      //   height: size.height*.005,
                      // ),
                      Container(
                        width: size.width*.59,

                        child: Row(
                          children: [
                            Text("${Favorite['condition']}",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                              fontFamily: second_font,

                            )),
                            SizedBox(
                              width: size.width*.12,
                            ),
                            Text("${Favorite['Price']}",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                              fontFamily: second_font,

                            )),
                            Expanded(
                              child: SizedBox(
                                width: size.width*.045,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: ()
                              async {
                                await FirebaseFirestore.instance.collection('Favorite').
                                doc(docid).delete();
                              },
                              icon:
                              // CircleAvatar(
                              //   radius: 15.0,
                              //   backgroundColor:second_color,
                              //
                              //   child:
                                Icon(
                                  Icons.favorite,
                                  //size: 34.0,
                                  color: second_color,
                                ),
                              ),
                            // ),
                            // Icon(
                            //   Icons.favorite,
                            //   color: second_color,
                            //   size: 24.0,
                            // ),
                          ],

                        ),
                      )
                    ],
                  ),


                ],
              ),



            ),
          ),
        ),
        SizedBox(
          height: size.height * .01,
        ),
      ],
    );
  }
}


