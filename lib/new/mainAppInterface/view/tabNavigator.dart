import 'package:deepblue/new/mainAppInterface/view/appScreen.dart';
import 'package:deepblue/new/mainAppInterface/view/bottomNavigation.dart';

import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
  static const String test = '/test';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context) {                      //funktion zum durchführen des Stack calls ? 
    var routeBuilders = _routeBuilders(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.test](context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context) => AppScreen(),
      /*
      
      TabNavigatorRoutes.root: (context) => ColorsListPage(                           //root Route
            color: TabHelper.color(tabItem),
            title: TabHelper.description(tabItem),
            onPush: () =>                                                //was soll bei onPush passieren -> _push wird aufgerufen und TabNavigatorROutesDetial aufgerufen
                _push(context),
          ),*/

    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
        key: navigatorKey,
        initialRoute: TabNavigatorRoutes.root,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        });
  }
}