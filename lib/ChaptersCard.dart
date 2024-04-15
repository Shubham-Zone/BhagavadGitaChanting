import 'package:flutter/material.dart';
import 'package:gitachanting/SloksList.dart';

Widget lessonUi(String lesson,BuildContext context){

  return InkWell(
    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SloksList(lesson))),
    child: Container(
        margin:  const EdgeInsets.only(left: 6,right: 6,top: 5,bottom: 5),
        decoration:   const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.amber,
            boxShadow: [
              BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 1,
                  color: Colors.grey,
                offset: Offset(0, 6)
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/om.png',height: 60,width: 55,),
             const SizedBox(
              height: 6,
            ),
            Text(lesson, style:  const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),),
            const SizedBox(
              height: 6,
            ),
          ],
        )
    ),
  );
}