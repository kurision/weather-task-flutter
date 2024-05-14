import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_task/features/homepage/views/homepage_view.dart';
import 'package:weather_task/features/splash/help_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('assets/images/back.jpg'), context);
    precacheImage(const AssetImage('assets/animassets/anim_1.json'), context);
    super.didChangeDependencies();
  }

  Future navigate() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('isFirstTime') == null || prefs.getBool('isFirstTime') == true
        ? Future.delayed(const Duration(seconds: 4), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const HelpScreen();
                },
              ),
            );
          })
        : Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const HomePageView())));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 100,
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
