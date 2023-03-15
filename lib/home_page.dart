import 'package:firebase_crud/second_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          elevation: 0,
          actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_forward,color: Colors.black,),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SecondPage(); // 遷移先の画面widgetを指定
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ]),
      body:Center(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 250,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                    child: Center(
                        child: Text("MyText", style: TextStyle(fontSize: 20))
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,

                      ),
                    ],
                  ),
                  child: Center(
                      child: Text("MyText", style: TextStyle(fontSize: 20))
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 350,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                    child: Center(
                        child: Text("MyText", style: TextStyle(fontSize: 20))
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text("MyText", style: TextStyle(fontSize: 20))
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    width: 350,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                    child: Center(
                        child: Text("MyText", style: TextStyle(fontSize: 20))
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text("MyText", style: TextStyle(fontSize: 20))
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        tooltip: 'Add Note',
        shape: const CircleBorder(
            side: BorderSide(color: Colors.black, width: 2.0)),
        child: const Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.white,
      ),
    );
  }
  }

