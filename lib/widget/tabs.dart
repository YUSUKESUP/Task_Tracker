import 'package:firebase_crud/pages/calender_page.dart';
import 'package:firebase_crud/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/setting.dart';
import '../state/app_state.dart';
import '../state/firebase_provider.dart';
import 'mordal.dart'; // modal が正しい　スペルチェッカー入ってなければ入れよう。

class TabsPage extends ConsumerWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //タブ
    const selectedColor = Colors.black;
    const unselectedColor = Color(0xff5f6368);

    /// このちぐはぐな変数はよくなさそう
    /// textProvider から controllerProvider がでてきたらびっくりせえへん？
    /// textEditingControllerProvider -> textEditingController ならわかる。
    /// 他の人が読んで意味が伝わるか？　を常にチェックするといい。
    final controllerProvider = ref.watch(textProvider);

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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  color: Colors.black,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SettingPage();
                      },
                    ),
                  ),
                ),
              ),
            ]),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: unselectedColor,
                  labelColor: selectedColor,
                  indicatorColor: selectedColor,
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
              const Expanded(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              context: context,
              barrierColor: Colors.black.withOpacity(0.2),
              builder: (BuildContext context) {
                return MordalPage(
                  controller: controllerProvider,
                  onPress: () {
                    ref
                        .read(appStateProvider.notifier)
                        .textAdd(controllerProvider.text);
                    controllerProvider.clear();
                    Navigator.pop(context);
                  },
                  buttonName: 'タスクを追加',
                );
              },
            );
          },
          shape: const CircleBorder(
              side: BorderSide(color: Colors.black, width: 2.0)),
          backgroundColor: Colors.white,
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}
