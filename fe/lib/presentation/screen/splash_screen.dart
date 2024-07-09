import 'package:flutter/material.dart';
import 'package:fe/presentation/screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay navigation to LoginScreen for 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Color.fromARGB(0, 255, 239, 9),
              radius: 200.0,
              child: Image.asset('images/logo.png'),
            ),
            const SizedBox(height: 16),
            CircularProgressIndicator(
              color: Colors.black, // Set the color to yellow
            ),
          ],
        ),
      ),
    );
  }
}
