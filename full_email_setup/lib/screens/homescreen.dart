import 'package:flutter/material.dart';
import 'inbox_screen.dart';
import 'draft_screen.dart';
import 'compose_screen.dart';
import 'sent_screen.dart';
import 'important_screen.dart';
import 'settings_screen.dart';
import 'account_screen.dart';
import 'login_screen.dart' ;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isSearchBarVisible = false;
  bool _isComposeScreenOpen = false;

  final List<Widget> _widgetOptions = <Widget>[
    InboxScreen(),
    const DraftScreen(),
    ComposeScreen(),
    const SentScreen(),
    const ImportantScreen(),
    const SettingsScreen(),
    const AccountScreen(),
  ];

  void _setComposeScreenOpen(bool isOpen) {
    setState(() {
      _isComposeScreenOpen = isOpen;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      _setComposeScreenOpen(true);
    } else {
      _setComposeScreenOpen(false);
    }
  }

  void _toggleSearchBar() {
    setState(() {
      _isSearchBarVisible = !_isSearchBarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _toggleSearchBar,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _onItemTapped(5),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => _onItemTapped(6),
          ),
        ],
        bottom: _isSearchBarVisible
            ? PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              )
            : null,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: Visibility(
        visible: !_isComposeScreenOpen,
        child: FloatingActionButton.extended(
          onPressed: () => _onItemTapped(2),
          tooltip: 'Compose',
          icon: const Icon(Icons.create),
          label: const Text('Compose'),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Email App',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.inbox),
              title: const Text('Inbox'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.drafts),
              title: const Text('Draft'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.create),
              title: const Text('Compose'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.send),
              title: const Text('Sent'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(3);
              },
            ),
            ListTile(
              leading: const Icon(Icons.label_important),
              title: const Text('Important'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(4);
              },
            ),
          ],
        ),
      ),
    );
  }
}
