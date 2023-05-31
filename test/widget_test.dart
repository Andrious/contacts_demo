///

import './src/view.dart';

import 'package:integration_test/integration_test.dart'
    show IntegrationTestWidgetsFlutterBinding;

void main() => testMyApp();

/// Also called in package's own testing file, test/widget_test.dart
void testMyApp() {
  //
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Registers a function to be run once after all tests.
  /// Be sure the close the app after all the testing.
  tearDownAll(() {});

  /// Define a test. The TestWidgets function also provides a WidgetTester
  /// to work with. The WidgetTester allows you to build and interact
  /// with widgets in the test environment.
  testWidgets('contacts_demo testing', (WidgetTester tester) async {
    //
    final app = DemoApp();

    await tester.pumpWidget(app);

    /// Flutter won’t automatically rebuild your widget in the test environment.
    /// Use pump() or pumpAndSettle() to ask Flutter to rebuild the widget.

    /// pumpAndSettle() waits for all animations to complete.
    await tester.pumpAndSettle();

    /// Contacts app
    await contactsTest(tester);

    /// Open the Locale window
    await openLocaleMenu(tester);

    /// Open About menu
    await openAboutMenu(tester);

    /// Switch the Interface
    await openInterfaceMenu(tester);

    reportTestErrors();
  });
}
