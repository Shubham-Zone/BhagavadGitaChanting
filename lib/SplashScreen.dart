import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gitachanting/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));

    Timer(Duration(seconds: 3), () {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
   });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    var mediaQuery=MediaQuery.of(context);

    return Scaffold(
      body: Center(
        child: Container(
          // height: double.infinity,
          // width: double.infinity,
          // color: Colors.white,
          child: Image.asset("assets/images/hindu.png",height: mediaQuery.size.height*0.5,width: mediaQuery.size.width*0.5,),
        ),
      ),
    );
  }
}
