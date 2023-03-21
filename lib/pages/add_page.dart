
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/firebase_provider.dart';
import '../utils/app_state.dart';

class AddPage extends ConsumerWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // textProviderを呼び出す定数を定義
    final controllerProvider = ref.watch(textProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controllerProvider, //providerに定義したコントローラーを使う
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '文字を入力してください',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    // ref.readでStateNotifierを呼び出す.
                    // controllerProvider.textと書いて
                    ref
                        .read(appStateProvider.notifier)
                        .textAdd(controllerProvider.text);
                    Navigator.pop(context);
                  },
                  child: Text('新規登録')),
            ],
          ),
        ),
      ),
    );
  }
}