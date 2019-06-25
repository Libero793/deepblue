import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { home, search, map, locations, profile }               //zur Auswahl stehende Tab Items 

class TabHelper {
  static TabItem item({int index}) {                                // Item type nach indeces identifizieren 
    switch (index) {
      case 0:
        return TabItem.home;
      case 1:
        return TabItem.search;
      case 2:
        return TabItem.map;
      case 3:
        return TabItem.locations;
      case 4:
        return TabItem.profile;
    }
    return TabItem.home;
  }

  static String description(TabItem tabItem) {                      //Beschreibung der einzelnen Menüpuntkte 
    switch (tabItem) {
      case TabItem.home:
        return 'home';
      case TabItem.search:
        return 'suche';
      case TabItem.map:
        return 'map';
      case TabItem.locations:
        return 'locations';
      case TabItem.profile:
        return 'profile';
    }
    return '';
  }

  static MaterialColor color(TabItem tabItem) {                         //Farbe der Detail Page 
    switch (tabItem) {
      case TabItem.home:
        return Colors.red;
      case TabItem.search:
        return Colors.green;
      case TabItem.map:
        return Colors.blue;
      case TabItem.locations:
        return Colors.orange;
      case TabItem.profile:
        return Colors.yellow;
    }
    return Colors.grey;
  }
}

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;


  @override
  Widget build(BuildContext context) {                        // Navigation bar bauen 
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.home),
        _buildItem(tabItem: TabItem.search),
        _buildItem(tabItem: TabItem.map),
        _buildItem(tabItem: TabItem.locations),
        _buildItem(tabItem: TabItem.profile),
      ],
      onTap: (index) => onSelectTab(
        TabHelper.item(index: index),
      ),
      selectedFontSize: 12,
      unselectedFontSize: 12,
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {     //NavigationBarItems bauen 

    String text = TabHelper.description(tabItem);
    return BottomNavigationBarItem(
      icon: Icon(
        _iconTabMatching(item: tabItem),
        color: _colorTabMatching(item: tabItem),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(item: tabItem),        
        ),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {                         //Farbe der icons und texte in Navi Bar 
    return currentTab == item ? Colors.white : Colors.grey;
  }

  IconData _iconTabMatching({TabItem item}){                      // Icons der einzelnen Menüpunkte 
    switch (item) {
      case TabItem.home :
        return Icons.home;
      case TabItem.search :
        return Icons.search;
      case TabItem.map :
        return Icons.map;
      case TabItem.locations :
        return Icons.location_on;
      case TabItem.profile :
        return Icons.person;
    }
  }
}