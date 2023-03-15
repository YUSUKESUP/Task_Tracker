import 'dart:ffi';

import 'package:firebase_crud/third_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {


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
                            return ThirdPage();
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
                        width: 1,
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
                      width: 1,
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
                        width: 1,
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
                      width: 1,
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
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 350,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
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
                      width: 1,
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
    );
  }
}
