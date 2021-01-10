import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/home/home_screen.dart';
//import 'package:shop_app/screens/profile/profile_screen.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Colors.deepPurpleAccent;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -1),
            blurRadius: 20,
            color: Colors.cyan,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
               /*  onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName),
              ), */
              ),
              IconButton(
                icon: SvgPicture.asset("assets/Heart Icon.svg"),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset("assets/Chat bubble Icon.svg"),
                onPressed: () {},
              ),
               IconButton(
                icon: SvgPicture.asset("assets/Chat bubble Icon.svg"),
                onPressed: () {},
              ),

              /* IconButton(
                icon: SvgPicture.asset(
                  "assets/User Icon.svg",
                   color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor, 
                    
                ), */
              /*   onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName),
              ), */
              
            ],
          )),
    );
  }
}
