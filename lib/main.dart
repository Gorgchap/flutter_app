import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/posts.dart';
import 'package:flutter_app/models/settings.dart';
import 'package:flutter_app/widgets/add-new-post.dart';
import 'package:flutter_app/widgets/gallery.dart';
import 'package:flutter_app/widgets/profile.dart';
import 'package:flutter_app/widgets/settings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostsModel()),
        ChangeNotifierProvider(create: (context) => SettingsModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppStatefulWidget(),
    );
  }
}

class AppStatefulWidget extends StatefulWidget {
  const AppStatefulWidget({Key? key}) : super(key: key);

  @override
  State<AppStatefulWidget> createState() => _AppState();
}

class _AppState extends State<AppStatefulWidget> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    ProfileWidget(),
    GalleryWidget(),
    AddNewPostWidget(),
    SettingsWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 30),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: 30),
            label: 'Add new post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
