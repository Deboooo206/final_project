import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_agraa_project/screen/ueser/the_final_form.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class shops extends StatelessWidget {
  var Search;
  var Area;
  var condition;
  var select;

  shops({this.Search,this.Area,this.condition,this.select});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: size.height * .01,
          ),
          StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore.instance.collection('products').
              where("Name",isEqualTo:Search).
                  where("condition",isEqualTo:condition).
              where("Area_of_shop",isEqualTo:Area).orderBy("${select}")
                  .snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount:snapshot.data!.docs.length ,
                      itemBuilder:(context, i){
                        // var products;
                        return Listshop(
                          shop:snapshot.data!.docs[i],
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


    );
  }
}
class Listshop extends StatelessWidget {

  var shop;
  var docid;

  Listshop({this.shop, this.docid,});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var view= shop['view'];
    view++;
    print (view);
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => the_final_form(docid:docid,list:shop,),)
              );
              await FirebaseFirestore.instance.collection('products').doc(docid).update(
                        {
                          "view": view,

                        });

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
                          backgroundImage: NetworkImage("${shop['imageurl_of_shop']}",

                          ),),
                      ),
                      SizedBox(
                        width: size.width*.045,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Expanded(
                            child: SizedBox(
                              height: size.height*.009,
                            ),
                          ),
                          Container(
                            width: size.width*.65,
                            height: size.height*.035,

                            child: Text("${shop['Name_of_shop']}",
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
                              height: size.height*.009,
                            ),
                          ),
                          Text("${shop['Price']}",
                              style: TextStyle(
                                fontSize:size.width*.04,
                                fontFamily: second_font,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,


                              )),
                          Expanded(
                            child: SizedBox(
                              height: size.height*.009,
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
