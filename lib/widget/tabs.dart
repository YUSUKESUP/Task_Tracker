import 'package:firebase_crud/pages/calender_page.dart';
import 'package:firebase_crud/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/setting_notification.dart';


class TabsPage extends ConsumerWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {


    final _selectedColor = Colors.black;
    final _unselectedColor = Color(0xff5f6368);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Task Tracker',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: const Color(0xffFDF3E6),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  color: Colors.black,
                  onPressed: () =>
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return   SettingPage();
                          },
                        ),
                      ),
                ),
              ),
            ]),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children:  [
              Container(
                color: Color(0xffFDF3E6),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: _unselectedColor,
                  labelColor: _selectedColor,
                  indicatorColor: _selectedColor,
                  indicator: BoxDecoration(

                    border: Border(
                      bottom: BorderSide(
                        width: 3,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  tabs: [
                    Tab(text: 'HeatMap'),
                    Tab(text: 'Calender'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    HomePage(),
                    CalenderPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}