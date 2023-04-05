import 'package:flutter/material.dart';

class WithdrawalPage extends StatelessWidget {
  const WithdrawalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('退会完了'),
      ),
      body: Center(
        child: Column(
          children: const [
            Text('退会手続きを完了いたしました!'),
            SizedBox(height: 20),
            Text('アプリを終了してください')
          ],
        ),
      ),
    );
  }
}