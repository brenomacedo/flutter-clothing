import 'package:flutter/material.dart';
import 'package:virtual_store/pages/home_tab.dart';

class HomeScreen extends StatelessWidget {

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        HomeTab()
      ],
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
    );
  }
}