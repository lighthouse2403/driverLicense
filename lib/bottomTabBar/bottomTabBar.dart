import 'package:flutter/material.dart';
import 'package:license/Setting/setting.dart';
import '../Home/home.dart';

class MainBottomTabBar extends StatefulWidget {
  const MainBottomTabBar({super.key});

  @override
  State<MainBottomTabBar> createState() => _MainBottomTabBarState();
}

class _MainBottomTabBarState extends State<MainBottomTabBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lime[800],
        onTap: _onItemTapped,
      ),
    );
  }

  // FUNCTION
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}