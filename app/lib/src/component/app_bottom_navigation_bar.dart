import 'package:app/src/const.dart';
import 'package:app/src/provider/cart_provider.dart';
import 'package:app/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final StatefulNavigationShell? statefulNavigationShell;

  const AppBottomNavigationBar({required this.statefulNavigationShell, super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
  
    UserProvider userProvider = Provider.of<UserProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    if(!userProvider.isLogin) {
      return const SizedBox();
    }

    return Stack(
      children: [
        SlidingClippedNavBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onButtonPressed: (index) {
            setState(() {
              _selectedIndex = index;
            });
            widget.statefulNavigationShell!.goBranch(index);
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
        ),
        if(_selectedIndex != 2)
          Positioned(
            right: (MediaQuery.of(context).size.width / 3) / 2 - 45,
            top: 25,
            child: Container(
              alignment: Alignment.center,
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onPrimary,
                )
              ),
              child: Text(
                cartProvider.productCount.toString(),
                style: Theme.of(context).textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
      ],
    );
  }

}
