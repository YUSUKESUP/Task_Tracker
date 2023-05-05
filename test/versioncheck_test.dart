import 'package:firebase_crud/provider/version_check.dart';
import 'package:firebase_crud/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';


class MockVersionCheckDialog extends Mock implements VersionCheckDialog {}

void main() {
  testWidgets('MyApp should initialize versionCheckDialogProvider',
          (WidgetTester tester) async {
        final mockVersionCheckDialog = MockVersionCheckDialog();
        final versionCheckDialogProviderOverride =
        Provider((ref) => mockVersionCheckDialog);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              versionCheckDialogProvider.overrideWith(versionCheckDialogProviderOverride),
            ],
            child: const MyApp(),
          ),
        );

        verify(mockVersionCheckDialog.versionCheck(any, any)).called(1);
      });
}
