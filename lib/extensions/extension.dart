import 'package:flutter/material.dart';

/// [extensionで画面遷移のWidgetを作成する関数を作成]
extension BuildContextE on BuildContext {
  Future<void> to(Widget view) async {
    await Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) {
          return view;
        },
      ),
    );
  }
}