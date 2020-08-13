import 'package:flutter/material.dart';
import 'package:soft_bloc/widgets/intro_widgets/intro_screen_onboarding.dart';
import 'package:soft_bloc/widgets/intro_widgets/introduction.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Splash'),
        ),
      ),
    );
  }
}

class IntroScreen extends StatelessWidget {

  final List<Introduction> list = [
    Introduction(
      title: 'Buy & Sell',
      subTitle: 'Browse the menu and order directly from the application',
      imageUrl: 'assets/images/onboarding3.png',
    ),
    Introduction(
      title: 'Delivery',
      subTitle: 'Your order will be immediately collected and',
      imageUrl: 'assets/images/onboarding4.png',
    ),
    Introduction(
      title: 'Receive Money',
      subTitle: 'Pick up delivery at your door and enjoy groceries',
      imageUrl: 'assets/images/onboarding5.png',
    ),
    Introduction(
      title: 'Finish',
      subTitle: 'Browse the menu and order directly from the application',
      imageUrl: 'assets/images/onboarding3.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: IntroScreenOnboarding(
        introductionList: list,
        onTapSkipButton: () {Navigator.pushNamed(context, "/");},
      )
    );
  }
}
