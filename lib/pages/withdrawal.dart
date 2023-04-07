import 'package:flutter/material.dart';

class WithdrawalPage extends StatelessWidget {
  const WithdrawalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDF3E6),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xffFDF3E6),
        automaticallyImplyLeading: false,
        title: const Text('退会完了',style: TextStyle(
          color: Colors.black,
        ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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