//

import 'package:fluttery_framework/controller.dart' as c;

import 'package:contacts_demo/src/view.dart';

/// StateX controller with event functions highlighted.
class StateXController extends c.StateXController {
  /// Optionally supply a State object.
  StateXController([StateX? state]) : super(state);

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('###########  initState() in $this');
    }
  }

  @override
  void activate() {
    super.activate();
    if (kDebugMode) {
      print('###########  activate() in $this');
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    if (kDebugMode) {
      print('###########  deactivate() in $this');
    }
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print('###########  dispose() in $this');
    }
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    if (kDebugMode) {
      print('###########  didPopRoute() in $this');
    }
    return false;
  }

  @override
  Future<bool> didPushRoute(String route) async {
    if (kDebugMode) {
      print('###########  didPushRoute() in $this');
    }
    return false;
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    if (kDebugMode) {
      print('###########  didPushRouteInformation() in $this');
    }
    return didPushRoute(routeInformation.location!);
  }

  @override
  void didChangeMetrics() {
    if (kDebugMode) {
      print('###########  didChangeMetrics() in $this');
    }
  }

  @override
  void didChangeTextScaleFactor() {
    if (kDebugMode) {
      print('###########  didChangeTextScaleFactor() in $this');
    }
  }

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    if (kDebugMode) {
      print('###########  didChangePlatformBrightness() in $this');
    }
  }

  /// Locale changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    if (kDebugMode) {
      print('###########  didChangeLocales() in $this');
    }
  }

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  @override
  void pausedLifecycleState() {
    if (kDebugMode) {
      print('###########  pausedLifecycleState() in $this');
    }
  }

  /// Either be in the progress of attaching when the engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  @override
  void detachedLifecycleState() {
    if (kDebugMode) {
      print('###########  detachedLifecycleState() in $this');
    }
  }

  /// The application is visible and responding to user input.
  @override
  void resumedLifecycleState() {
    if (kDebugMode) {
      print('###########  resumedLifecycleState() in $this');
    }
  }

  @override
  void didHaveMemoryPressure() {
    if (kDebugMode) {
      print('###########  didHaveMemoryPressure() in $this');
    }
  }

  @override
  void didChangeAccessibilityFeatures() {
    if (kDebugMode) {
      print('###########  didChangeAccessibilityFeatures() in $this');
    }
  }
}
