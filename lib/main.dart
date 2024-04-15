import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gitachanting/ChaptersCard.dart';
import 'package:gitachanting/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Gita chanting",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const SplashScreen(),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return WillPopScope(

        onWillPop: () async {
          onBackPressed();
          return false;
        },

        child:Scaffold(

            appBar: AppBar(
              title: Text("Gita chanting"),
              automaticallyImplyLeading: false, // Hide the back arrow button
            ),

            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 5,
                children: [
                  lessonUi("अध्याय 1", context),
                  lessonUi("अध्याय 2", context),
                  lessonUi("अध्याय 3", context),
                  lessonUi("अध्याय 4", context),
                  lessonUi("अध्याय 5", context),
                  lessonUi("अध्याय 6", context),
                  lessonUi("अध्याय 7", context),
                  lessonUi("अध्याय 8", context),
                  lessonUi("अध्याय 9", context),
                  lessonUi("अध्याय 10", context),
                  lessonUi("अध्याय 11", context),
                  lessonUi("अध्याय 12", context),
                  lessonUi("अध्याय 13", context),
                  lessonUi("अध्याय 14", context),
                  lessonUi("अध्याय 15", context),
                  lessonUi("अध्याय 16", context),
                  lessonUi("अध्याय 17", context),
                  lessonUi("अध्याय 18", context),
                ],
              ),

            )

        )
    );

  }

  void onBackPressed() { exit(0);}

}
