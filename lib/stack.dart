import 'package:flutter/material.dart';

class StackedContainer extends StatefulWidget {
  const StackedContainer({Key? key}) : super(key: key);

  @override
  State<StackedContainer> createState() => _StackedContainerState();
}

class _StackedContainerState extends State<StackedContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 112,
              left: 87,
              width: 200,
              height: 200,
              child: Container(
                width: 250,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.yellow,
                    ),
                  ],
                ),
                child: Center(
                    child: Text("MyText", style: TextStyle(fontSize: 20))
                ),
              )
          ),
          Positioned(
              top: 100,
              left: 75,
              width: 200,
              height: 200,
              child: Container(
                width: 250,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                    ),
                  ],
                ),
                child: Center(
                    child: Text("MyText", style: TextStyle(fontSize: 20))
                ),
              )
          ),
        ],
      ),
    );
  }
}
