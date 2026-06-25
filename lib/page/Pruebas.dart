
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/components/Radio.dart';

class Pruebas extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(176, 47, 47, 192),

      ),
      child: 
      Column(
        children: [
          Radiow(),
          Container(
            child: Text('App Version: Snapshot 0.3'),
          ),
          Container(
            child: Text('Made By: Volunteer Lenin Ospina L.'),
          ),
          Container(
            child: Text('For entertainment purposes only. No guarantees'),
          )
        ],
      ),
    );
  }

}