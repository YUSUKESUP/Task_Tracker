import 'package:firebase_crud/data/version_check.dart';
import 'package:firebase_crud/provider/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';


void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
        packageInfoProvider.overrideWith((ref) => PackageInfo(appName: 'TestPackageTnfo', packageName: 'com.TestPackageTnfo', version: '1.0.0', buildNumber: '1',)),
      ],
    );
  });

  testWidgets('Firestoreと端末のバージョンが違うためダイアログが出るパターン',
          (WidgetTester tester) async {
        // Firestoreに登録するテスト用のバージョン情報
        const iosVersion = '2.0.0';
        const androidVersion = '2.0.0';
        final firestore = container.read(firebaseFirestoreProvider);
        await firestore.collection('config').doc('nu7t69emUsaxYajqJEEE').set({
          'ios_force_app_version': iosVersion,
          'android_force_app_version': androidVersion,
        });

        // PackageInfo.fromPlatform() のモック
        final fakePackageInfo = container.read(packageInfoProvider);

        when(fakePackageInfo).thenReturn('1.0.0' as AsyncValue<PackageInfo>);

        // versionCheck() 関数を実行し、アップデートダイアログが表示されることを確認
        await tester.runAsync(() async {
          await versionCheck();
          await tester.pumpAndSettle();
          expect(find.text('New version available!'), findsOneWidget);
        });
      });
}


// testWidgets(
// 'Firestoreと端末のバージョンが同じためダイアログが出ないパターン',
// (WidgetTester tester) async {
// // Firestoreに登録するテスト用のバージョン情報
// const iosVersion = '1.0.0';
// const androidVersion = '1.0.0';
// final firestore = container.read(firebaseFirestoreProvider);
// await firestore.collection('config').doc('nu7t69emUsaxYajqJEEE').set({
// 'ios_force_app_version': iosVersion,
// 'android_force_app_version': androidVersion,
// });
//
// // PackageInfo.fromPlatform() のモック
// final fakePackageInfo = MockPackageInfo();
// when(fakePackageInfo.version).thenReturn('1.0.0');
//
//
// // BuildContextのモック
// final mockContext = MockBuildContext();
//
// // versionCheck() 関数を実行し、アップデートダイアログが表示されないことを確認
// await tester.runAsync(() async {
// await versionCheck(mockContext);
// await tester.pumpAndSettle();
// expect(find.text('New version available!'), findsNothing);
// });
// },
// );