import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffFDF3E6),
      ),
      backgroundColor: Color(0xffFDF3E6),
      // backgroundColor: Color(0xff6795a0),
      // backgroundColor: Color(0xffe36962),
      // backgroundColor: Color(0xffebc57c),
      // backgroundColor: Color(0xffdad5d2),
      // backgroundColor: Color(0xff6795a0),
      // backgroundColor: Color(0xff9e504d),
      // backgroundColor: Color(0xff807f6b),
      // backgroundColor: Color(0xffddc8c1),
      // backgroundColor: Color(0xffac7041),
      // backgroundColor: Color(0xffc76e54),
      // backgroundColor: Color(0xfff5cdbd),
      // backgroundColor: Color(0xfff5ece4),
      // backgroundColor: Color(0xffbf9288),
      // backgroundColor: Color(0xfff5b09b),
      // backgroundColor: Color(0xffe7b564),
      // backgroundColor: Color(0xffa3b1b4),
      // backgroundColor: Color(0xff5b8f8f),

      body: SafeArea(
        child: Center(
          child:  Column(
            children: [
              SizedBox(height: 30),
              Container(
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(5, 5)
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    '今日やることはプログラミングです',
                    style: GoogleFonts.mochiyPopOne(
                      color: Color(0xFF000000),
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width: 250,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(5, 5)
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Center(
                    child: Text("MyText", style: TextStyle(fontSize: 20))
                ),
              ),
             SizedBox(height: 30,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     width: 150,
                     height: 70,
                     decoration: BoxDecoration(
                       border: Border.all(
                         color: Colors.black,
                         width: 2,
                       ),
                       borderRadius: BorderRadius.circular(30),
                       boxShadow: const [
                         BoxShadow(
                             color: Colors.black,
                             blurRadius: 1,

                         ),
                       ],
                       color: Colors.white,
                     ),
                     child: Center(
                       child: Text(
                         '勉強',
                         style: GoogleFonts.bizUDGothic(
                           color: Color(0xFF000000),
                           fontSize: 20.0,
                         ),
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     width: 150,
                     height: 70,
                     decoration: BoxDecoration(
                       border: Border.all(
                         color: Colors.black,
                         width: 2,
                       ),
                       borderRadius: BorderRadius.circular(30),
                       boxShadow: const [
                         BoxShadow(
                           color: Colors.black,
                           blurRadius: 1,

                         ),
                       ],
                       color: Colors.white,
                     ),
                     child: Center(
                       child: Text(
                         '勉強',
                         style: GoogleFonts.bizUDGothic(
                           color: Color(0xFF000000),
                           fontSize: 20.0,
                         ),
                       ),
                     ),
                   ),
                 ),
               ],
             ),
              SizedBox(height: 30),
              Container(

                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,

                    ),
                  ],
                  color: Color(0xffa3b1b4),
                ),
                child: Center(
                  child: Text(
                    'Save',
                    style: GoogleFonts.mochiyPopOne(
                      color: Color(0xFF000000),
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
