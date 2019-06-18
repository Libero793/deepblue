import 'package:deepblue/new/controller/navigationController.dart';
import 'package:deepblue/new/view/bottomNavigation.dart';
import 'package:deepblue/new/view/tabNavigator.dart';
import 'package:flutter/material.dart';

class NavigationView extends NavigationController{

TabItem currentTab = TabItem.search;                                  //Start tab
  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {         //Navigation möglichkeiten ?
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.map: GlobalKey<NavigatorState>(),
    TabItem.locations: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
     // onWillPop: () async =>
          //!await navigatorKeys[currentTab].currentState.maybePop(),
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.home),                        //offstage für jeden Tab erstellen 
          _buildOffstageNavigator(TabItem.search),
          _buildOffstageNavigator(TabItem.map),
          _buildOffstageNavigator(TabItem.locations),
          _buildOffstageNavigator(TabItem.profile),
        ]),
        bottomNavigationBar: BottomNavigation(                          //Navigation Bar am unteren Bildschirmrand 
          currentTab: currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {                   //Seiten Screen 
    return Offstage(
      offstage: currentTab != tabItem,
      child: 
      TabNavigator(
        navigatorKey: navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}

