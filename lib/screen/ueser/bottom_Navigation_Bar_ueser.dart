import 'package:new_agraa_project/screen/ueser/Favorite.dart';
import 'package:new_agraa_project/screen/ueser/chat_ueser.dart';
import 'package:new_agraa_project/screen/ueser/home.dart';
import 'package:new_agraa_project/screen/ueser/ueser_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '../welcome_screen.dart';


class bottom_Navigation_Bar_ueser extends StatefulWidget {

  @override
  State<bottom_Navigation_Bar_ueser> createState() => _bottom_Navigation_Bar_ueserState();
}

class _bottom_Navigation_Bar_ueserState extends State<bottom_Navigation_Bar_ueser> {
  List<Widget>screens =[
    Favorite(),
    home(),
    chat_ueser(),

  ];
  int currentIndex =1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ueser_information(),)
          );
          },icon: Icon(
          Icons.account_circle,
        ),),
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
        fixedColor:main_color ,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {

            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.favorite
              ),
              label: 'Favorite'

          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.home),
              label: 'home'

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

