import 'package:flutter/material.dart';

Widget VersesCard(String SlokNo){

  return Container(
    height: 60,
    margin: EdgeInsets.all(15),
    decoration: const BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.all(Radius.circular(40)),
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              spreadRadius: 2,
              color: Colors.transparent,
              offset: Offset(0, 10)
          )
        ]
    ),
    child:Center(
      child: Text("श्लोक $SlokNo",style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),),
    ),
  );

}