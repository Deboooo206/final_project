import 'package:new_agraa_project/screen/ueser/shops.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../constant.dart';

class search_products extends StatefulWidget {

  @override
  State<search_products> createState() => _search_productsState();
}

class _search_productsState extends State<search_products> {
  dynamic condition_search='New';
  var AreaController = TextEditingController();
  var searchController = TextEditingController();
  var list =['Price','time'];
  var select ='Price';

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
              height: size.height*.02,
            ),
            Center(
              child: defaultTextFormField3(
                width: size.width*0.9,
                text: "search",
                prefix: Icons.search,
                controller:searchController,

              ),
            ),
            SizedBox(
              height: size.height*.04,
            ),
            Center(
              child: defaultTextFormField3(
                width: size.width*0.9,
                text: "Area",
                prefix: Icons.add_location,
                controller:AreaController,

              ),
            ),
            SizedBox(
              height: size.height*.04,
            ),

            Row(
              children: [
                SizedBox(
                  width: size.width*.05,
                ),
                Radio(
                  value: 'New',
                  groupValue: condition_search,
                  onChanged: (value) {
                    setState(() {
                      condition_search = value;
                    });
                  },
                  activeColor: main_color,

                ),
                Text(
                  'New', style: TextStyle(
                 // fontFamily: main_font,
                  color: Colors.grey.shade400,
                  fontSize: size.width*.06,
                ),
                )
              ],

            ),
            Row(
              children: [
                SizedBox(
                  width: size.width*0.05,
                ),
                Radio(
                  value: 'Used',
                  groupValue: condition_search,
                  onChanged: (value) {
                    setState(() {
                      condition_search = value;
                    });
                  },
                  activeColor: main_color,

                ),
                Text(
                  'Used', style: TextStyle(
                 // fontFamily: second_font,
                  color: Colors.grey.shade400,
                  fontSize: size.width*.06,
                ),
                )
              ],

            ),
            Row(
              children: [
                SizedBox(
                  width: size.width*0.1,
                ),
                Text('Sort by',style:TextStyle(color:Colors.grey.shade400, fontSize: size.width*.06) ,),
                Expanded(
                  child: SizedBox(
                    width: size.width*0.1,
                  ),
                ),
                DropdownButton<String>(
                  style:TextStyle(color:main_color, fontSize: size.width*.06),
                  items: list.map((String item){
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),);
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      select=value!;
                    });
                  },
                  value: select,
                ),

                SizedBox(
                  width: size.width*0.1,
                ),
              ],
            ),
            SizedBox(
              height: size.height*.2,
            ),
            defaultButton(
              text: 'Search',
              width: size.width*.6,
              height:size.height*0.055,
              function: (){

          if(searchController.text!=''){
            if(AreaController.text!=''){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => shops(
                        Search:searchController.text,
                        Area:AreaController.text,
                        condition:condition_search,
                        select:select,


                    ),)
              );
            }

          }
        //print (select);

              },

            )
            // Column(
            //   children: [
            //     GestureDetector(
            //       onTap: (){
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => the_final_form(),)
            //         );
            //       },
            //       child: Center(
            //         child: Container(
            //             width: size.width*.9,
            //             height: size.height*.1,
            //             decoration: BoxDecoration(
            //                 borderRadius:BorderRadius.circular(10),
            //                 color: Colors.white,
            //                 border:Border.all(color: Colors.grey.shade400,)
            //             ),
            //             child: Row(
            //               children: [
            //                 SizedBox(
            //                   width: size.width*.045,
            //                 ),
            //                 Container(
            //                   width: size.width*.15,
            //                   child: CircleAvatar(
            //                     radius: size.width*.075,
            //                     backgroundImage: AssetImage('images/a.jpg'),
            //
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: size.width*.045,
            //                 ),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //
            //                   children: [
            //                     Expanded(
            //                       child: SizedBox(
            //                         height: size.height*.009,
            //                       ),
            //                     ),
            //                     Container(
            //                       width: size.width*.65,
            //                       height: size.height*.035,
            //
            //                       child: Text('Name of shop',
            //                         maxLines: 1,
            //                         textScaleFactor:.85,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(
            //
            //                           fontSize:size.width*.06,
            //                           fontFamily: main_font,
            //                           fontWeight: FontWeight.bold,
            //                           color: second_color,
            //                         ),),
            //                     ),
            //                     Expanded(
            //                       child: SizedBox(
            //                         height: size.height*.009,
            //                       ),
            //                     ),
            //                     Text(' 6000',
            //                         style: TextStyle(
            //                           fontSize:size.width*.04,
            //                           fontFamily: second_font,
            //                           fontWeight: FontWeight.bold,
            //                           color: Colors.grey.shade400,
            //
            //
            //                         )),
            //                     Expanded(
            //                       child: SizedBox(
            //                         height: size.height*.009,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //
            //               ],
            //             )
            //         ),
            //       ),
            //     ),
            //
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}