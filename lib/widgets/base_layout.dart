import 'package:flutter/material.dart';

class BaseLayout extends StatefulWidget {
  final Widget child;
  final VoidCallback? onThemeToggle;
  final String currentRoute;

  const BaseLayout({
    Key? key,
    required this.child,
    this.onThemeToggle,
    required this.currentRoute,
  }) : super(key: key);

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
  }

  @override
  void didUpdateWidget(BaseLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentRoute != widget.currentRoute) {
      _updateSelectedIndex();
    }
  }

  void _updateSelectedIndex() {
    switch (widget.currentRoute) {
      case '/home':
        _selectedIndex = 0;
        break;
      case '/educational_content':
        _selectedIndex = 1;
        break;
      case '/specialist_search':
        _selectedIndex = 2;
        break;
      case '/specialist_registration':
        _selectedIndex = 3;
        break;
      default:
        _selectedIndex = 0;
    }
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/educational_content');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/specialist_search');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/specialist_registration');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Find Specialist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Join Us',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
} 