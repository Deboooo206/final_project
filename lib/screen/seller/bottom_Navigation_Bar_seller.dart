import 'package:new_agraa_project/screen/seller/Products.dart';
import 'package:new_agraa_project/screen/account.dart';
import 'package:new_agraa_project/screen/seller/chat_seller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '../welcome_screen.dart';
import 'Seller_information.dart';

class bottom_Navigation_Bar_seller extends StatefulWidget {

  @override
  State<bottom_Navigation_Bar_seller> createState() => _bottom_Navigation_Bar_sellerState();
}

class _bottom_Navigation_Bar_sellerState extends State<bottom_Navigation_Bar_seller> {
  List<Widget>screens =[
    Seller_information (),
    Products(),
    chat_seller(),

  ];
  int currentIndex =1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) => welcome_screen(),), (route) => false);
            },icon: Icon(
            Icons.logout,
          ),)
        ],
      ),
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        fixedColor:main_color,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {

            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.account_circle
              ),
              label: 'Account'

          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.shopping_cart),
              label: 'Products'

          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.chat),
              label: 'Chat'

          ),


        ],
      ),
    );

  }

}