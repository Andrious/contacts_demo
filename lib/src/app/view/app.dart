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
  AppState createAppState() => _AppState();
}

/// This is the 'View' of the application.
/// The 'look and behavior' of the app.
class _AppState extends AppState {
  ///
  _AppState()
      : super(
          controller: DemoController(),
          controllers: [
            ThemeController(),
            ContactsController(),
          ],
          debugShowCheckedModeBanner: false,
          // debugPaintSizeEnabled: true,
          title: 'Contacts App Demo',
          switchUI: Prefs.getBool('switchUI'),
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
          localizationsDelegates: [
            L10n.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
        );

  @override
  Locale? onLocale() {
    return (controller as DemoController).appLocale();
  }

  @override
  Widget onHome() => (controller as DemoController).onHome();
}
