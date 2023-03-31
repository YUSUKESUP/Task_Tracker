import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/components/month_summary.dart';
import 'package:firebase_crud/pages/setting_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_state.dart';
import '../utils/auth_controll.dart';
import '../utils/firebase_provider.dart';

class HomePage extends ConsumerWidget {

   const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final AsyncValue<QuerySnapshot> firebaseTasks = ref.watch(firebaseTasksProvider);


    final controllerProvider = ref.watch(textProvider);



    return Scaffold(
      backgroundColor: const Color(0xffFDF3E6),
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
                icon: const Icon(Icons.notifications),
                color: Colors.black,
                onPressed: () =>

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return  SettingNotificationPage();
                        },
                      ),
                    ),
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const MonthlySummary(

            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 72.0),
            //   child: SvgPicture.asset(
            //     'assets/undraw_add_files_re_v09g.svg',
            //     semanticsLabel: 'shopping',
            //     width: 200,
            //     height: 200,
            //   ),
            // ),

            firebaseTasks.when(
              data: (QuerySnapshot query) {
                return Expanded(
                  child: ListView(
                    children: query.docs.map((document) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                          height: 400,
                                          child: Center(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                TextFormField(
                                                  controller:
                                                      controllerProvider,
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        UnderlineInputBorder(),
                                                    labelText: '文字を入力してください',
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      ref
                                                          .read(appStateProvider
                                                              .notifier)
                                                          .textUpdate(
                                                              document,
                                                              controllerProvider
                                                                  .text);
                                                      controllerProvider.clear();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('編集')),
                                                const SizedBox(height: 40),
                                                ElevatedButton(
                                                  child: const Text('閉じる'),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ])));
                                    });
                              },
                              backgroundColor: Colors.grey.shade800,
                              icon: Icons.settings,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                ref
                                    .read(appStateProvider.notifier)
                                    .deleteMemo(document);
                              },
                              backgroundColor: Colors.red.shade400,
                              icon: Icons.delete,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 75,
                            child: Center(
                              child: ListTile(
                                leading: Checkbox(
                                  activeColor: Colors.black,
                                  value: document['isDone'],
                                  onChanged: (bool? value) {
                                    FirebaseFirestore.instance.collection('users').doc('uid').collection('memos').doc(document.id).update({'isDone':value});
                                  },
                                ),
                                title: Text(document['text'],
                                  overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                   decoration:document['isDone'] ?? false ?
                                   TextDecoration.lineThrough
                                   : TextDecoration.none

                                ),
                                  ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
              loading: () {
                return const Text('Loading');
              },
              error: (e, stackTrace) {
                return Text('error: $e');
              },
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
            builder: (BuildContext ctx) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: controllerProvider,
                        decoration: InputDecoration(
                          labelText: '文字を入力してください',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      InkWell(
                        onTap: () {
                          ref
                              .read(appStateProvider.notifier)
                              .textAdd(controllerProvider.text);
                          controllerProvider.clear();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'タスクを追加',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
    );
  }
}
