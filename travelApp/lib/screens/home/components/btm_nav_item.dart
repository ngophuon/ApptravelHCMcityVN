
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:complex_ui_rive_animation/models/menu.dart';
import 'package:complex_ui_rive_animation/screens/AIchat/chat_page.dart';
import '../../entry/components/animated_bar.dart';
import 'package:complex_ui_rive_animation/screens/map/map1.dart';
import 'package:complex_ui_rive_animation/weather/main1.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:complex_ui_rive_animation/profile/profile_page.dart';

class BtmNavItem extends StatelessWidget {
  const BtmNavItem(
      {super.key,
        required this.navBar,
        required this.press,
        required this.riveOnInit,
        required this.selectedNav});

  final Menu navBar;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final Menu selectedNav;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

        if (navBar.title == "Chat") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatGPTScreen_1()), // Chuyển đến màn hình chat
          );
        }
        if(navBar.title == "Search"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Map_sc1()),
          );
        }
        if (navBar.title == "Timer") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProviderScope(child: MyApp1()),
            ),
          );
        }
        if (navBar.title == "Profile") {
          User? user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

            String username = userSnapshot.get('confetti') ?? '';
            String email = userSnapshot.get('email') ?? '';

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(username: username, email: email),
              ),
            );
          }
        }

      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: selectedNav == navBar),
          SizedBox(
            height: 36,
            width: 36,
            child: Opacity(
              opacity: selectedNav == navBar ? 1 : 0.5,
              child: RiveAnimation.asset(
                navBar.rive.src,
                artboard: navBar.rive.artboard,
                onInit: riveOnInit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
