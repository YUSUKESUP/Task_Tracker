import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MordalPage extends StatelessWidget {
  final controller;
  final VoidCallback onPress;
  final String buttonName;

  const MordalPage({
    Key? key,
    required this.controller,
    required this.onPress,
    required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: controller,
              decoration: InputDecoration(
                labelText: '文字を入力してください',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: onPress,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    buttonName,
                    style: const TextStyle(
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
  }
}
