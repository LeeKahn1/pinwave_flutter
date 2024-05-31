import 'package:flutter/material.dart';
import 'package:tubes_pinwave/module/create_pin/create_pin_page.dart';
import 'package:tubes_pinwave/module/home/home_page.dart';
import 'package:tubes_pinwave/module/notification/notification_page.dart';
import 'package:tubes_pinwave/module/profile/profile_page.dart';
import 'package:tubes_pinwave/module/search/search_page.dart';

class NavMenuPage extends StatefulWidget{
  const NavMenuPage({super.key,  required this.title});

  final String title;
  @override
  State<NavMenuPage> createState() => _NavMenuPageState();
}

class _NavMenuPageState extends State<NavMenuPage> {
  int selected = 0;
  PageController pc = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: pc,
          onPageChanged: (index) {
            setState(() {
              selected = index;
            });
          },
          children: [
            const HomePage(), // Ganti dengan BerandaPage()
            SearchPage(), // Ganti dengan SearchPage()
            const CreatePinPage(),
            const NotificationPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.blue,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
          });
          pc.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label : 'search'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, size: 48),
              label : ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'notification',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            label: "profile",
          )
        ],
      ),
    );
  }
}