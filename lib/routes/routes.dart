import 'package:flutter/material.dart';

class Routes {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory Routes() => _instance;

  Routes._internal();

  static final Routes _instance = Routes._internal();

  static Routes get instance => _instance;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToWithoutDuplicate(String routeName,
      {dynamic arguments}) async {
    if (navigatorKey.currentState?.currentRouteName == routeName) {
      return null;
    }
    return navigateTo(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
          (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateAndReplace(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndReplaceName(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  dynamic pop({dynamic result}) {
    return navigatorKey.currentState?.pop(result);
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    String routeName = settings.name ?? '';
    switch (routeName) {
      default:
        return null;
    }
  }

  static MaterialPageRoute _pageRoute({
    RouteSettings? setting,
    required Widget page
  }) {
    return MaterialPageRoute(
      builder: (context) => page,
      settings:
      RouteSettings(arguments: setting?.arguments, name: setting?.name),
    );
  }
}

extension NavigatorStateX on NavigatorState {
  String? get currentRouteName {
    String? currentPath;
    popUntil((route) {
      currentPath = route.settings.name;
      return true;
    });
    return currentPath;
  }
}
