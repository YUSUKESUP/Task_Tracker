import 'package:crud_app/ui/pages/add_page.dart';
import 'package:crud_app/extensions/extension.dart';
import 'package:crud_app/ui/pages/read_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.to(const ReadPage());
                },
                child: Text('データを表示')),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  context.to(const AddPage());
                },
                child: Text('データを追加')),
          ],
        ),
      ),
    );
  }
}