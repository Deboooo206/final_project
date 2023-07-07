import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../constant.dart';
import 'Enter_products.dart';
import 'edit_Products.dart';

class Products extends StatelessWidget {
 // var products;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Enter_products(),)
          );
        },
        child: Icon(
          Icons.add,
        ), backgroundColor: main_color,

      ),
      body: SingleChildScrollView(

        child: Column(
          children: [
           SizedBox(
          height: size.height * .01,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('products').
                where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount:snapshot.data!.docs.length ,
                        itemBuilder:(context, i){
                         // var products;
                          return ListProducts(
                              Products:snapshot.data!.docs[i],
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

class ListProducts extends StatelessWidget {

  var Products;
  var docid;

  ListProducts({this.Products, this.docid,});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        children: [
          Container(

              width: size.width * .9,
              height: size.height * .18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 6.0,
                      spreadRadius: 4,
                      offset: Offset(3.0, 3.0), //(x,y)

                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade400,)
              ),
              child: Column(
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(10),
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network("${Products['imageurl']}",
                          fit: BoxFit.fill,
                          height: size.height * 0.14,
                          width: size.width * 0.285,

                        ),
                      ),
                      SizedBox(
                        width: size.width * .03,
                      ),
                      Container(
                        width: size.width * .43,
                        //height:size.height*0.14 ,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   height: size.height*.01,
                            // ),

                            Container(
                              width: size.width * .47,

                              child: Text("${Products['Name']}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: size.width * .047,
                                  fontFamily: main_font,
                                  fontWeight: FontWeight.bold,
                                  color: second_color,
                                ),),
                            ),

                            SizedBox(
                              height: size.height * .01,
                            ),

                            Text("${Products['condition']}", style: TextStyle(
                              fontSize: size.width * .045,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                              fontFamily: second_font,

                            )),
                            SizedBox(
                              height: size.height * .01,
                            ),
                            Text("${Products['Price']}", style: TextStyle(
                              fontSize: size.width * .045,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                              fontFamily: second_font,

                            )),
                            SizedBox(
                              height: size.height * .01,
                            ),

                          ],
                        ),
                      ),
                      Container(
                        width: size.width * .13,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => edit_Products(docid:docid,list:Products),)
                                );

                              },
                              icon: CircleAvatar(
                                radius: size.width * .04,
                                backgroundColor: second_color,

                                child: Icon(
                                  Icons.edit,
                                  size: size.width * .04,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async{
                               await FirebaseFirestore.instance.collection('products').
                                doc(docid).delete();
                              },
                              icon: CircleAvatar(
                                radius: size.width * .04,
                                backgroundColor: second_color,

                                child: Icon(
                                  Icons.remove,
                                  size: size.width * .05,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: size.width * .01,
                        ),
                      ),

                      Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey.shade400,
                        size: 24.0,
                      ),
                      SizedBox(
                        width: size.width * .02,
                      ),
                      Text(
                          "${Products['view']}", style: TextStyle(
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
                        Icons.favorite,
                        color: Colors.grey.shade400,
                        size: 24.0,
                      ),
                      SizedBox(
                        width: size.width * .02,
                      ),
                      Text(
                          "${Products['Favorite']}", style: TextStyle(
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
                        Icons.call,
                        color: Colors.grey.shade400,
                        size: 24.0,
                      ),
                      SizedBox(
                        width: size.width * .02,
                      ),
                      Text(
                          "${Products['chat']}", style: TextStyle(
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
                  )

                ],
              )


          ),
          SizedBox(
          height: size.height * .01,
          ),
        ],
      ),
    );
  }
}

