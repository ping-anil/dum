import 'package:aa/utils/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../res/dimens.dart';
import '../login/LoginScreen.dart';
import '../loginSignupSelection/LoginSignupSelectionScreen.dart';
import 'Splash.dart';

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _checkAlreadyLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Lottie.asset('lottieFiles/splash_wallet.json'),
      ), //center
    ); //scaffold
  }


  void _navigateToLogin() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginScreen()
        ));
  }

  void _navigateToLoginSignupSelection() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignInOutScreen()));
  }

  void _checkAlreadyLoggedIn() async {
    bool isLoggedIn = await SecureStorage.doesHaveMnemonic();
    await Future.delayed(const Duration(seconds: 5), () {
      if (isLoggedIn) {
        _navigateToLogin();
      } else {
        _navigateToLoginSignupSelection();
      }
    });
  }
}
