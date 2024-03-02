import 'package:app/src/const.dart';
import 'package:app/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
  
    UserProvider userProvider = Provider.of<UserProvider>(context);

    if(!userProvider.isLogin) {
      return const SizedBox();
    }

    return SlidingClippedNavBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      onButtonPressed: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      iconSize: 30,
      activeColor: Theme.of(context).colorScheme.secondary,
      inactiveColor: disabledColor,
      selectedIndex: _selectedIndex,
      barItems: [
        BarItem(
          icon: Icons.home,
          title: 'Accueil',
        ),
        BarItem(
          icon: Icons.account_circle,
          title: 'Profil',
        ),
        BarItem(
          icon: Icons.shopping_cart,
          title: 'Panier',
        ),
      ],
    );
  }

}
