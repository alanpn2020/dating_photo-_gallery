import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        Scaffold(
            appBar: AppBar(
              title: Text("Alan & Karoline"),
              centerTitle: true,
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(

                    ),
                  ),
                  ListTile(
                    title: Text('Item1',style: TextStyle(color: Colors.yellow),  ),
                    tileColor: Colors.red,
                   onTap: (){}
                  ), 
                  ListTile(
                    title: Text('Item1'),
                   onTap: (){}
                  ),
                  ListTile(
                    title: Text('Item1'),
                   onTap: (){}
                  ),
                ]
              ) ,),

            body: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('mensagens').snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 12,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0))),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: snapshot.data.docs[index].get('image'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (index) {
                            return StaggeredTile.count(
                                1, index.isEven ? 1.2 : 1.8);
                          });
                })),
      ],
    );
  }
}

class FirebaseStorage {}
