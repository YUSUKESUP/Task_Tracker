import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_crud/application/provider/firebase_provider.dart';
import 'package:firebase_crud/application/provider/version_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  group('versionCheckリポジトリー', () {
    late ProviderContainer container;

    setUp(() async {
      // テスト用のProviderContainerを定義
       container = ProviderContainer(
        overrides: [
          packageInfoProvider,
          firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
        ],
      );
    });

    testWidgets(
        '強制アップデートの設定とアプリのパッケージ情報が同じ場合はアップデートダイアログが表示されない',
            (tester) async {
          await tester.runAsync(() async {
            // Firestoreに強制アップデート用の設定を保存
            await container.read(firebaseFirestoreProvider)
                .collection('config')
                .doc('nu7t69emUsaxYajqJEEE')
                .set({
              'ios_force_app_version': '1.0.0',
              'android_force_app_version': '1.0.0',
            });
            /// アプリのパッケージ情報を定義
            final packageInfo = PackageInfo(
              appName: 'test',
              packageName: 'com.example.test',
              version: '1.0.0',
              buildNumber: '1',
            );

            await tester.pumpAndSettle();
            expect(find.byType(Dialog), findsNothing);
          });
        });
      },
    );
}