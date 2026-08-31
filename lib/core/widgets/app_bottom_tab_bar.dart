import 'package:assignment/core/widgets/navbar_widget/app_navigation_bar.dart';
import 'package:assignment/core/widgets/side_menu.dart';
import 'package:assignment/features/booking_hotel/presentation/screens/booking_hotel_screen.dart';
import 'package:assignment/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:assignment/features/hotel_resort/presentation/screens/hotel_resort_screen.dart';
import 'package:assignment/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<int> _tabHistory = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = const [
    DashboardScreen(),
    HotelResortScreen(),
    BookingHotelScreen(),
    ProfileScreen(),
  ];

  void _handleBackPressed() {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
      return;
    }

    if (_currentIndex == 0) {
      SystemNavigator.pop();
      return;
    }

    setState(() {
      _currentIndex = _tabHistory.isEmpty ? 0 : _tabHistory.removeLast();
    });
  }

  void _handleTabSelected(int index) {
    if (index == _currentIndex) {
      return;
    }

    setState(() {
      if (index == 0) {
        _tabHistory.clear();
      } else {
        _tabHistory.add(_currentIndex);
      }

      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        _handleBackPressed();
      },
      child: Scaffold(
        key: _scaffoldKey,

        backgroundColor: Colors.transparent,
        extendBody: true,

        drawer: const SideMenu(),
        drawerEnableOpenDragGesture: true,

        body: Stack(
          children: [
            IndexedStack(index: _currentIndex, children: _screens),

            if (_currentIndex == 0)
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                right: 20,
                child: Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: const Color(0xFF173449),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF23465D)),
                        ),
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),

        bottomNavigationBar: SafeArea(
          top: false,
          minimum: const EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: AppNavigationBar(
            currentIndex: _currentIndex,
            onTap: _handleTabSelected,
          ),
        ),
      ),
    );
  }
}
