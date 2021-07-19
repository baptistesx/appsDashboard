import 'package:flutter/material.dart';
import 'package:lachenal_app/pages/home_page.dart';

import 'pages/apps_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => HomePage(
                data:
                    HomePageParams(title: "Lycée Louis Lachenal - BTS Bois")));
      case '/apps':
        return MaterialPageRoute(
            builder: (_) => AppsPage(
                data:
                    AppsPageParams(title: "Lycée Louis Lachenal - BTS Bois")));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
