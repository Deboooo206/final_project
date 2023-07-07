import 'package:flutter/material.dart';

import '../../components.dart';
import 'maintenance_information.dart';

class search_maintenance extends StatelessWidget {
  var AreaController = TextEditingController();
  //var Search;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [

          SizedBox(
            height: size.height*.02,
          ),
          Center(
            child: defaultTextFormField3(
              width: size.width*0.9,
              text: "Area",
              prefix: Icons.search,
              controller:AreaController,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: size.height*.02,
            ),
          ),

          defaultButton(
            text: 'Search',
            width: size.width*.8,
            height:size.height*0.055,
            function: (){
              if(AreaController.text!=''){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => maintenance_information(
                          Search:AreaController.text
                      ),)
                );
              }

            },

          ),
          SizedBox(
            height: size.height*.05,
          ),

        ],
      ),
    );
  }
}
