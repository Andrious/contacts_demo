//
import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:fluttery_framework/view.dart' as v;

import 'package:contacts_demo/src/controller.dart';

/// Merely a subclass emphasising the event-handling capabilities of the StateX
class StateX<T extends StatefulWidget> extends v.StateX<T> {
  /// Optionally supply a SOC (State Object Controller)
  StateX([StateXController? _controller]) : super(controller: _controller);
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('###########  initState() in $this');
    }
  }

  @override
  Widget build(context) {
    if (kDebugMode) {
      print('###########  build() in $this');
    }
    return super.build(context);
  }

  @override
  Widget buildAndroid(context) {
    if (kDebugMode) {
      print('###########  build() in $this');
    }
    return super.build(context);
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
    await super.didPopRoute();
    if (kDebugMode) {
      print('###########  didPopRoute() in $this');
    }
    return false;
  }

  @override
  Future<bool> didPushRoute(String route) async {
    await super.didPushRoute(route);
    if (kDebugMode) {
      print('###########  didPushRoute() in $this');
    }
    return false;
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    super.didPushRouteInformation(routeInformation);
    if (kDebugMode) {
      print('###########  didPushRouteInformation() in $this');
    }
    return didPushRoute(routeInformation.location!);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (kDebugMode) {
      print('###########  didChangeMetrics() in $this');
    }
  }

  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
    if (kDebugMode) {
      print('###########  didChangeTextScaleFactor() in $this');
    }
  }

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (kDebugMode) {
      print('###########  didChangePlatformBrightness() in $this');
    }
  }

  /// Locale changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
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
    super.didHaveMemoryPressure();
    if (kDebugMode) {
      print('###########  didHaveMemoryPressure() in $this');
    }
  }

  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
    if (kDebugMode) {
      print('###########  didChangeAccessibilityFeatures() in $this');
    }
  }
}
