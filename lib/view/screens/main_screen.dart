import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/screens/cart_screen.dart';
import 'package:jewelry/view/screens/catalog_screen.dart';
import 'package:jewelry/view/screens/profile_screen.dart';
import 'package:jewelry/view/widgets/app_bottom_navbar_item.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    const HomeScreen(),
    const CatalogScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Card(
            elevation: 0.0,
            shape: const Border(
              top: BorderSide(width: 0.1, color: AppColors.hintColor)
            ),
            margin: EdgeInsets.zero,
            color: AppColors.background,
            child: SizedBox(
              height: 70.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppBottomNavBarItem(
                      icon: Icons.home_rounded,
                      label: "Главная",
                      isSelected: _selectedIndex == 0,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      }
                  ),
                  AppBottomNavBarItem(
                      icon: Icons.apps_rounded,
                      label: "Каталог",
                      isSelected: _selectedIndex == 1,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                        });
                      }
                  ),
                  AppBottomNavBarItem(
                      icon: Icons.shopping_cart_rounded,
                      label: "Корзина",
                      isSelected: _selectedIndex == 2,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 2;
                        });
                      }
                  ),
                  AppBottomNavBarItem(
                      icon: Icons.person_rounded,
                      label: "Профиль",
                      isSelected: _selectedIndex == 3,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 3;
                        });
                      }
                  ),
                ],
              ),
            ),
          ),
          body: _screens.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
