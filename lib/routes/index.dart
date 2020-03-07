import 'package:flutter/material.dart';
import 'package:flutter_ncov/pages/tabs/tabs.dart';
import 'package:flutter_ncov/pages/webview_details.dart';
import 'package:flutter_ncov/pages/tabs/statement.dart';

final routes = {
  '/': (context) => Tabs(),
  '/webview_details': (context, {arguments}) => WebviewDetailPages(
        arguments: arguments,
      ),
  '/statement': (context) => StatementPage()
};

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
