//

import 'dart:math' as math;

import 'package:contacts_demo/src/controller.dart';

import 'package:contacts_demo/src/model.dart';

import 'package:contacts_demo/src/view.dart';

/// The App's menu
class AppMenu {
  /// Only one instance of the class
  factory AppMenu() => _this ??= AppMenu._();

  /// Supply the
  AppMenu._() : _con = DemoController() {
    //
    App.menu.key = const Key('appMenuButton');

    /// When an menu item is selected
    App.menu.onSelected = (String value) async {
      switch (value) {
        case 'interface':
          _con.changeUI();
          break;
        case 'useMaterial3':
          _con.material3();
          break;
        case 'locale':
          await _con.changeLocale();
          break;
        case 'color':
          await _con.changeColor();
          break;
        case 'dark':
          _con.switchDarkMode();
          break;
        case 'left':
          _con.switchInterfaceSides();
          break;
        case 'about':
          _con.aboutApp();
          break;
        default:
      }
    };
  }
  static AppMenu? _this;

  /// The App's controller
  final DemoController _con;

  /// Supply the app's popupmenu
  /// a mutable menu
  Widget get popupMenuButton {
    /// Supply the menu options
    App.menu.menuEntries = [
      PopupMenuItem(
        key: const Key('interfaceMenuItem'),
        value: 'interface',
        child: Text(
            '${'Interface:'.tr} ${App.useMaterial ? 'Material' : 'Cupertino'}'),
      ),
      if (App.useMaterial) // Only available in the Material interface
        PopupMenuItem(
          key: const Key('useMaterial3'),
          value: 'useMaterial3',
          child: _con.useMaterial3ListTile,
        ),
      PopupMenuItem(
        key: const Key('localeMenuItem'),
        value: 'locale',
        child: Text('${'Locale:'.tr} ${App.locale!.toLanguageTag()}'),
      ),
      if (App.useMaterial) // Only available in the Material interface
        PopupMenuItem(
          key: const Key('colorMenuItem'),
          value: 'color',
          child: Text('Colour Theme'.tr),
        ),
      PopupMenuItem(
        key: const Key('darkMenuItem'),
        value: 'dark',
        child: _con.darkModeListTile,
      ),
      PopupMenuItem(
        key: const Key('leftMenuItem'),
        value: 'left',
        child: _con.onLeftSideSwitch,
      ),
      PopupMenuItem(
        key: const Key('aboutMenuItem'),
        value: 'about',
        child: Text('About'.tr),
      ),
    ];

    return App.menu.popupMenuButton;
  }

  /// the App's TabBar
  _TabsBar get tabBar {
    //
    double? size;
    final context = App.context;
    if (context != null) {
      final IconThemeData? iconTheme = IconTheme.of(context);
      size = iconTheme?.size;
    }
    size = size ?? 12;

    final tabs = <Widget>[
      InkWell(
        onTap: _con.addFontSize,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
          child: Icon(
            Icons.text_increase,
            size: size * 1.3,
            color: App.useCupertino ? null : Colors.white,
          ),
        ),
      ),
      InkWell(
        onTap: _con.subFontSize,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 10),
          child: Icon(
            Icons.text_decrease,
            color: App.useCupertino ? null : Colors.white,
          ),
        ),
      ),
    ];
    return _TabsBar(tabs: tabs);
  }
}

///
class _TabsBar extends StatelessWidget implements PreferredSizeWidget {
  ///
  const _TabsBar({
    super.key,
    required this.tabs,
  });

  ///
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final row = <Widget>[];
    if (tabs.isEmpty) {
      row.add(Container(height: 46 + 2.0));
    } else {
      for (final tab in tabs) {
        row.add(Flexible(child: tab));
      }
    }
    return Row(
      mainAxisAlignment:
          Settings.onLeftSide ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: row,
    );
  }

  /// [AppBar] uses this size to compute its own preferred size.
  @override
  Size get preferredSize {
    double maxHeight = 46;
    for (final Widget item in tabs) {
      if (item is PreferredSizeWidget) {
        final double itemHeight = item.preferredSize.height;
        maxHeight = math.max(itemHeight, maxHeight);
      }
    }
    return Size.fromHeight(maxHeight + 2.0);
  }
}
