import 'package:flutter/material.dart';
import 'package:vpn_app/home/presentation/screens/home_screen.dart';
import 'package:vpn_app/home/presentation/screens/location_screen.dart';
import 'package:vpn_app/route/routes.dart';

class RouteGenerator {
  RouteGenerator._();
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    Object? arguments = settings.arguments;
    switch (settings.name) {
      case Routes.homeScreenRoute:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.locationScreenRoute:
        return MaterialPageRoute(builder: (context) => const LocationScreen());
    }
    return null;
  }
}
