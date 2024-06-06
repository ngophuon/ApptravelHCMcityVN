import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:complex_ui_rive_animation/screens/blog/post_app_bar.dart';
import 'package:complex_ui_rive_animation/screens/blog/post_bottom_bar1.dart';

class otherScreen extends StatelessWidget{
  @override
  Widget build ( BuildContext context){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/dinhdoclapbg.jpg'),
          fit: BoxFit.cover,
          opacity: 0.7
          ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: PostAppBar(),
        ),
        bottomNavigationBar: PostBottomBar1(),
      ),
    );
  }
}