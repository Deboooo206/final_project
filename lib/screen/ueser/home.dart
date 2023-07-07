import 'package:new_agraa_project/screen/ueser/search_maintenance.dart';
import 'package:new_agraa_project/screen/ueser/search_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height*.05,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => search_products(),)
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      border:Border.all(color: Colors.grey.shade400,),
                      //borderRadius: BorderRadius.circular(10.0),

                  ),
                  height: size.height*0.3,
                  width: size.width*0.53,
                  child:
                  Column(
                    children: [
                      Image(
                        image: AssetImage('images/undraw_People_search_re_5rre.png'),
                        height: size.height*0.26,
                      ),
                      Text('Search For Products',style: TextStyle(

                          fontSize:size.height*.025,
                          fontFamily: main_font,
                          color: Colors.grey.shade400

                      ),),
                    ],
                  ),

                ),
              ),
            ),
            SizedBox(
              height: size.height*.05,
            ),
            Center(

              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => search_maintenance(),)
                  );
                },
                child: Container(
                  height: size.height*0.3,
                  width: size.width*0.53,
                  decoration: BoxDecoration(
                    border:Border.all(color: Colors.grey.shade400,),
                    //borderRadius: BorderRadius.circular(10.0),

                  ),

                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('images/undraw_product_iteration_kjok.png'),
                        height: size.height*0.26,
                      ),
                      Text('Maintenance',style: TextStyle(

                        fontSize:size.height*.025,
                        fontFamily: main_font,
                        color: Colors.grey.shade400

                      ),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height*.05,
            ),
          ],
        ),
      ),
    );
  }
}
