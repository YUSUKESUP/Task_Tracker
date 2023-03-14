import 'package:firebase_crud/second_page.dart';
import 'package:firebase_crud/stack.dart';
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
      body: Center(
        child: StackedContainer(),
      ),
    );
  }
}
