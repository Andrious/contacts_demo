//
import 'package:contacts_demo/src/controller.dart';

import 'package:contacts_demo/src/model.dart';

// You can see 'at a glance' this Controller also 'talks to' the interface (View).
import 'package:contacts_demo/src/view.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// The controller for the overall app
class DemoController extends AppController {
  ///
  factory DemoController() => _this ??= DemoController._();
  DemoController._();

  static DemoController? _this;

  /// Perform any asynchronous operation before proceeding with the app.
  @override
  Future<bool> initAsync([BuildContext? context]) async {
    //
    final init = await _setErrorHandler();

    return init;
  }

  /// Clear itself
  @override
  void dispose() {
    _this = null;
    super.dispose();
  }

  /// Assign to the 'leading' widget on the interface.
  void leading() => changeUI();

  /// Switch to the other User Interface.
  void changeUI() {
    //
    Navigator.popUntil(App.context!, ModalRoute.withName('/'));

    // This has to be called first.
    App.changeUI(App.useMaterial ? 'Cupertino' : 'Material');

    bool switchUI;
    if (App.useMaterial) {
      if (UniversalPlatform.isAndroid) {
        switchUI = false;
      } else {
        switchUI = true;
      }
    } else {
      if (UniversalPlatform.isAndroid) {
        switchUI = true;
      } else {
        switchUI = false;
      }
    }
    Prefs.setBool('switchUI', switchUI);
  }

  ///
  Widget onHome() => const ContactsList();

  /// App's Localization
  Locale appLocale() {
    Locale locale;

    /// Prefer the preference
    final localeTag = Prefs.getString('locale');
    final codes = localeTag.split('-');
    if (codes.length == 2) {
      locale = Locale(codes[0], codes[1]);
    } else {
      // the app's locale
      locale = L10n.locale;
      // Possibly the device's locale.
      locale = App.locale!;
    }
    return locale;
  }

  /// Change Locale
  Future<void> changeLocale() async {
    /// Prefer the preference
    final localeTag = Prefs.getString('locale');

    final codes = localeTag.split('-');

    Locale locale;
    if (codes.length == 2) {
      locale = Locale(codes[0], codes[1]);
    } else {
      locale = App.locale!;
    }

    final locales = App.supportedLocales!;

    final initialItem = locales.indexOf(locale);

    final spinner = ISOSpinner(
        initialItem: initialItem,
        supportedLocales: locales,
        onSelectedItemChanged: (int index) async {
          // Retrieve the available locales.
          final locale = L10n.getLocale(index);
          if (locale != null) {
            App.locale = locale;
            await Prefs.setString('locale', locale.toLanguageTag());
            // App.setState(() {});
            App.refresh();
          }
        });

    await DialogBox(
      title: 'Current Language'.tr,
      body: [spinner],
      press01: () {
        spinner.onSelectedItemChanged(initialItem);
      },
      press02: () {},
      switchButtons: Settings.onLeftSide,
    ).show();
  }

  /// Switch the current Dark Mode status
  void switchDarkMode() => ThemeController().switchDarkMode();

  /// Tile to supply the app's dark mode or light mode.
  Widget get darkModeListTile => ThemeController().darkModeListTile;

  /// Switch some Interface components to the other side.
  void switchInterfaceSides() => ThemeController().switchInterfaceSides();

  /// Interface components on the left side or right side
  Widget get onLeftSideSwitch => ThemeController().onLeftSideSwitch;

  /// Change the app's colour theme
  Future<void> changeColor() async {
    // Get the current colour.
    ColorPicker.color = Color(App.themeData!.primaryColor.value);

    await ColorPicker.showColorPicker(
        context: App.context!,
        onColorChange: (Color value) {
          /// Implement to take in a color change.
        },
        onChange: ([ColorSwatch<int?>? value]) {
          App.setThemeData(swatch: value);
          App.setState(() {});
        },
        shrinkWrap: true);
  }

  /// Increase the Font size
  void addFontSize() => ContactsController().addFontSize();

  /// Decrease the font size
  void subFontSize() => ContactsController().subFontSize();

  /// About dialogue window
  void aboutApp() => showAboutDialog(
        context: App.context!,
        applicationName: App.state?.title ?? '',
        applicationVersion: 'version: ${App.version} build: ${App.buildNumber}',
      );

  /// Supply the app's popupmenu
  /// an immutable menu
  Widget get menu => PopupMenu(
        key: const Key('appMenuButton'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        position: PopupMenuPosition.under,
        menuEntries: [
          PopupMenuItem(
            key: const Key('interfaceMenuItem'),
            value: 'interface',
            child: Text(
                '${'Interface:'.tr} ${App.useMaterial ? 'Material' : 'Cupertino'}'),
          ),
          PopupMenuItem(
            key: const Key('localeMenuItem'),
            value: 'locale',
            child: Text('${'Locale:'.tr} ${App.locale!.toLanguageTag()}'),
          ),
          if (App.useMaterial)
            PopupMenuItem(
              key: const Key('colorMenuItem'),
              value: 'color',
              child: L10n.t('Colour Theme'),
            ),
          PopupMenuItem(
            key: const Key('aboutMenuItem'),
            value: 'about',
            child: L10n.t('About'),
          ),
        ],
        onSelected: (String value) async {
          switch (value) {
            case 'interface':
              changeUI();
              break;
            case 'locale':
              await changeLocale();
              break;
            case 'color':
              await changeColor();
              break;
            case 'about':
              aboutApp();
              break;
            default:
          }
        },
      );

  /// Define the error handling
  Future<bool> _setErrorHandler() async {
    //
    if (_errorHandlerSet) {
      // No need to continue
      return true;
    }

    // Allow for binding
    WidgetsFlutterBinding.ensureInitialized();

    /// Incorporate FirebaseCrashlytics into the app.
    // Allow for FirebaseCrashlytics.instance
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Supply Firebase Crashlytics
    final crash = FirebaseCrashlytics.instance;

    _errorHandlerSet = AppErrorHandler.set(
        handler: crash.recordFlutterError, report: crash.recordError);

    // If true, then crash reporting data is sent to Firebase.
    await crash.setCrashlyticsCollectionEnabled(!App.inDebugger);

    return true;
  }

  // Set true when the App's Error Handler is set
  bool _errorHandlerSet = false;
}
