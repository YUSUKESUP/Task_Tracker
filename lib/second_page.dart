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
      appBar: AppBar(),
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
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
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
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
        ],
      ),
    );
  }
}
