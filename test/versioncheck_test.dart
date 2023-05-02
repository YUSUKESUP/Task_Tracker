import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MockPackageInfo extends Mock implements PackageInfo {}

void main() {
  group('versionCheck', () {
    testWidgets('should show update dialog if version is older than Firestore config',
            (WidgetTester tester) async {
          final firestore = FakeFirebaseFirestore();

          // Firestoreに登録するテスト用のバージョン情報
          final iosVersion = '2.0.0';
          final androidVersion = '2.0.0';
          await firestore.collection('config').doc('nu7t69emUsaxYajqJEEE').set({
            'ios_force_app_version': iosVersion,
            'android_force_app_version': androidVersion,
          });

          // PackageInfo.fromPlatform() のモック
          final fakePackageInfo = MockPackageInfo();
          when(fakePackageInfo.version).thenReturn('1.0.0');

          // versionCheck() 関数を実行し、アップデートダイアログが表示されることを確認
          await tester.runAsync(() async {
            await versionCheck(firestore, fakePackageInfo, context: null);
            await tester.pumpAndSettle();
            expect(find.text('New version available!'), findsOneWidget);
          });

          // アップデートをスキップした場合、ダイアログが消えることを確認
          await tester.tap(find.text('Skip'));
          await tester.pumpAndSettle();
          expect(find.text('New version available!'), findsNothing);
        });

    testWidgets('should not show update dialog if version is equal or newer than Firestore config',
            (WidgetTester tester) async {
          final firestore = FakeFirebaseFirestore();

          // Firestoreに登録するテスト用のバージョン情報
          final iosVersion = '2.0.0';
          final androidVersion = '2.0.0';
          await firestore.collection('config').doc('nu7t69emUsaxYajqJEEE').set({
            'ios_force_app_version': iosVersion,
            'android_force_app_version': androidVersion,
          });

          // PackageInfo.fromPlatform() のモック
          final fakePackageInfo = MockPackageInfo();
          when(fakePackageInfo.version).thenReturn(iosVersion); // Firestoreに登録したバージョンと同じか新しいバージョンを指定

          // versionCheck() 関数を実行し、アップデートダイアログが表示されないことを確認
          await tester.runAsync(() async {
            await versionCheck(firestore, fakePackageInfo, context: null);
            await tester.pumpAndSettle();
            expect(find.text('New version available!'), findsNothing);
          });
        });
  });
}
