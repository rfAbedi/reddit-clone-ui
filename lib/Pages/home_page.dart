import 'package:flutter/material.dart';
import '/Pages/setting_page.dart';
import '/Models/user_model.dart';
import '/Pages/feed_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  UserModel currentUser;
  int selectedIndex = 0;

  PageController controller = PageController();

  final List<Widget> _pages = <Widget>[
    FeedPage(),
    Center(child: Text('Forums Page')),
    Center(child: Text('Add Post Page')),
    SettingPage(),
  ];

  void onTapped(int index) {
    setState(() {
      controller.jumpToPage(index);
    });
  }

  void onPageTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: onPageTapped,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedIconTheme: IconThemeData(
          color: Colors.black26,
        ),
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home, color: Colors.deepOrange),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            activeIcon: Icon(Icons.list_alt, color: Colors.deepOrange),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            activeIcon: Icon(Icons.add, color: Colors.deepOrange),
            label: '',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          activeIcon: Icon(Icons.settings, color: Colors.deepOrange),
          label: '',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        onTap: onTapped,
      ),
    );
  }
}
