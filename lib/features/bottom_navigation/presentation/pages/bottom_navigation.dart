import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/chat/presentation/pages/chat_page.dart';
import 'package:growmind/features/favourites/presentation/favourite_pages.dart';
import 'package:growmind/features/home/presentation/pages/home_page.dart';
import 'package:growmind/features/profile/presentation/pages/profile_page.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;
  const BottomNavigation({super.key, this.initialIndex = 0,}); // Default: HomePage

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int currentIndex;
  final ValueNotifier<bool> bottomNavBarVisible = ValueNotifier(true);

  final List<Widget> listOfPages = [
    HomePage(),
    ChatPage(),
    FavouritePages(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void setPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            bottomNavBarVisible.value = true;
          } else if (notification.direction == ScrollDirection.forward) {
            bottomNavBarVisible.value = true;
          }
          return true;
        },
        child: IndexedStack(
          index: currentIndex,
          children: listOfPages,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: bottomNavBarVisible,
        builder: (context, isVisible, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isVisible ? kBottomNavigationBarHeight + 15 : 0,
            child: isVisible ? child : const SizedBox.shrink(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
              color: textColor,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: GNav(
                haptic: true,
                color: Colors.black, // Inactive icon color
                activeColor: Colors.white, // Active icon color
                gap: 8,
                onTabChange: setPage, // Updates current index
                textStyle: const TextStyle(color: Colors.white),
                tabBackgroundColor: mainColor,
                selectedIndex: currentIndex,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.chat,
                    text: 'Chat',
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Favourite',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
