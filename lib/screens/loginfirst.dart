import 'package:cafeite/screens/login_page.dart';
import 'package:cafeite/screens/loginadmin_page.dart';
import 'package:flutter/material.dart';

class LoginFirst extends StatefulWidget {
  const LoginFirst({super.key});

  @override
  _LoginFirstState createState() => _LoginFirstState();
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _GotonavigateToHome();
  }

  _GotonavigateToHome() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginFirst(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('logo.png'),
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class _LoginFirstState extends State<LoginFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('logo.png'),
              width: 150,
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32, // Mengubah ukuran font menjadi lebih besar
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginAdminPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Admin',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                  )),
                ),
                SizedBox(width: 20),
                Text('|', style: TextStyle(color: Colors.black, fontSize: 32)),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'User',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}