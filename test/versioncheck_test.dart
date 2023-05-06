import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_crud/data/version_check.dart';
import 'package:firebase_crud/provider/firebase_provider.dart';
import 'package:firebase_crud/widget/forced_update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  group('UpdateCheckService', () {
    late ProviderContainer container;
    late FakeFirebaseFirestore firestore;

    setUp(() async {
      firestore = FakeFirebaseFirestore();
      final packageInfo = PackageInfo(
        appName: 'test',
        packageName: 'com.example.test',
        version: '1.0.0',
        buildNumber: '1',
      );
      container = ProviderContainer(
        overrides: [
          packageInfoProvider,
          firebaseFirestoreProvider.overrideWithValue(firestore),
        ],
      );
      await firestore.collection('config').doc('nu7t69emUsaxYajqJEEE').set({
        'ios_force_app_version': '2.0.0',
        'android_force_app_version': '2.0.0',
      });
    });



    testWidgets(
        'do not show update dialog when there is no forced update available',
            (tester) async {
          await tester.runAsync(() async {
            // Set the current version to the latest version
            await firestore
                .collection('config')
                .doc('nu7t69emUsaxYajqJEEE')
                .set({
              'ios_force_app_version': '1.0.0',
              'android_force_app_version': '1.0.0',
            });
            final packageInfo = PackageInfo(
              appName: 'test',
              packageName: 'com.example.test',
              version: '1.0.0',
              buildNumber: '1',
            );
            final container = ProviderContainer(
              overrides: [
                packageInfoProvider,
                firebaseFirestoreProvider.overrideWithValue(firestore),
              ],
            );

            await tester.pumpAndSettle();
            expect(find.byType(Dialog), findsNothing);

          });
        });
  });
}
