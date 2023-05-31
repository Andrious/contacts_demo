//
import 'package:contacts_demo/src/controller.dart';

import 'package:contacts_demo/src/model.dart';

import 'package:contacts_demo/src/view.dart';

/// Passed to the runApp() function
class DemoApp extends AppStatefulWidget {
  ///
  DemoApp({super.key});

  // This is the 'App State object' of the application.
  @override
  AppState createAppState() => _DemoAppState();
}

/// This is the State object for the app.
class _DemoAppState extends AppState {
  ///
  _DemoAppState()
      : super(
          controller: DemoController(),
          controllers: [
            ThemeController(),
          ],
          debugShowCheckedModeBanner: false,
          inTheme: () =>
              ThemeData(useMaterial3: ThemeController().useMaterial3),
          // debugPaintSizeEnabled: true,
          title: 'Contacts App Demo',
          switchUI: Prefs.getBool('switchUI'),
          // inErrorHandler: (details) =>
          //     _firebaseCrashlytics.recordFlutterError(details),
          localizationsDelegates: [
            L10n.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          inSupportedLocales: () {
            /// The app's translations
            L10n.translations = {
              const Locale('zh', 'CN'): zhCN,
              const Locale('fr', 'FR'): frFR,
              const Locale('de', 'DE'): deDE,
              const Locale('he', 'IL'): heIL,
              const Locale('ru', 'RU'): ruRU,
              const Locale('es', 'AR'): esAR,
            };
            return L10n.supportedLocales;
          },
          home: const ContactsList(),
        ) {
    // Supply a reference to the App State's controller.
    con = controller as DemoController;
  }

  late DemoController con;

  // /// Perform any Asynchronous operations
  // @override
  // Future<bool> initAsync() async {
  //   //
  //   await super.initAsync();
  //
  //   // Allow for binding
  //   WidgetsFlutterBinding.ensureInitialized();
  //
  //   /// Incorporate FirebaseCrashlytics into the app.
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //
  //   // Supply Firebase Crashlytics
  //   _firebaseCrashlytics = FirebaseCrashlytics.instance;
  //
  //   return true;
  // }
  //
  // static late FirebaseCrashlytics _firebaseCrashlytics;
  //
  // /// Run the provided Error Handler if any.
  // @override
  // void onErrorHandler(FlutterErrorDetails details) =>
  //     _firebaseCrashlytics.recordFlutterError(details);
  //
  // /// If there's a error reporting routine available.
  // @override
  // Future<void> onErrorReport(Object exception, StackTrace stack) async {
  //   //
  //   await _firebaseCrashlytics.recordError(exception, stack);
  //
  //   // If true, then crash reporting data is sent to Firebase.
  //   await _firebaseCrashlytics
  //       .setCrashlyticsCollectionEnabled(!App.inDebugMode);
  // }

  @override
  Locale? onLocale() => con.appLocale();
}
