import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/provider/app_methods.dart';
import '../../application/provider/firebase_provider.dart';
import '../pages/home_page.dart';
import '../pages/setting.dart';
import 'modal.dart';

class TabsPage extends ConsumerWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ///タブ
    const selectedColor = Colors.black;
    const unselectedColor = Color(0xff5f6368);

    final textEditingControllerProvider = ref.watch(textEditingController);
    final appMethod = tasksRepositoryProvider;

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
               Expanded(
                child: TabBarView(
                  children: [
                    HomePage(
                      monthlySummaryMode: MonthlySummaryMode.heatMap,
                    ),
                    HomePage(
                      monthlySummaryMode: MonthlySummaryMode.calender,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              context: context,
              barrierColor: Colors.black.withOpacity(0.2),
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Padding(
                      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: MordalPage(
                      controller: textEditingControllerProvider,
                      onPress: () async {
                        ref
                            .read(appMethod)
                            .addTask(textEditingControllerProvider.text);
                        textEditingControllerProvider.clear();
                        Navigator.pop(context);
                      },
                      buttonName: 'タスクを追加',
                  ),
                    ),
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
