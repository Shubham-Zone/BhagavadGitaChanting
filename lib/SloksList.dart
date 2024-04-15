import 'package:flutter/material.dart';
import 'package:gitachanting/main.dart';
import 'SloksDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SloksCard.dart';


class SloksList extends StatefulWidget {

  final ch;
  SloksList(this.ch);


  @override
  State<SloksList> createState() => _SloksListState();
}

class _SloksListState extends State<SloksList> {

  late Stream<QuerySnapshot> Sloks;

  @override
  void initState() {
    super.initState();
    CollectionReference db =FirebaseFirestore.instance.collection(widget.ch);
    Sloks=db.snapshots();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(

        onWillPop: () async {
          onBackPressed();
          return false;
        },

        child:Scaffold(
            appBar: AppBar(
                title: Text(widget.ch)
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/sloklistbck.jpg"),
                    fit: BoxFit.cover
                ),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: Sloks,
                builder: (BuildContext context,AsyncSnapshot snapshot){

                  if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if(snapshot.connectionState==ConnectionState.active){

                    QuerySnapshot querySnapshot=snapshot.data;
                    List<QueryDocumentSnapshot> list=querySnapshot.docs;

                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context,index){
                          QueryDocumentSnapshot document=list[index];

                          return InkWell(
                              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SloksCard(document.get("SlokNo"), document.get("Slok"), document.get("Slokaudio"),document.get("Slokdetail"),document.get("Detailaudio"),widget.ch))),
                              child: VersesCard(document["SlokNo"])
                          );

                        }
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
        ) 
    );
    
  }

  void onBackPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
  }
}
//