import 'package:flutter/material.dart';

import 'constant.dart';

class test extends StatefulWidget {
  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  String? _selectedAnimal;

  final List<String> _suggestions = [
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Dog',
    'Eagle',
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eaglvve',
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Frog'
  ];

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Kindacode.com'),
      ),
      body: Column(
        children: [
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue value) {
              // When the field is empty
              if (value.text.isEmpty) {
                return [];
              }

              // The logic to find out which ones should appear
              return _suggestions.where((suggestion) =>
                  suggestion.toLowerCase().contains(value.text.toLowerCase()));
            },
            onSelected: (value) {
              setState(() {
                _selectedAnimal = value ;
                print(messageController);
              });
            },
          ),

          const SizedBox(
            height: 30,
          ),

          // Autocomplete<String>(
          //   optionsBuilder: (TextEditingValue value) {
          //         When the field is empty
          //
          //     if (value.text.isEmpty) {
          //       return [];
          //     }
          //     return _suggestions.where((suggestion) =>
          //         suggestion.toLowerCase().contains(value.text.toLowerCase()));
          //   },
          //   onSelected: (value) {
          //     setState(() {
          //
          //       messageController = value as TextEditingController ;
          //       print(messageController);
          //     });
          //   },
          //   // child: TextFormField(
          //   //   controller: messageController,
          //   // ),
          // ),

          IconButton(onPressed: (){
            print(_selectedAnimal);

          }, icon: Icon(Icons.import_contacts_sharp)),


        ],
      ),
    );
  }
}
