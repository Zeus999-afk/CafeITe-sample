import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafeite/utils/fire_auth.dart';
import 'package:cafeite/screens/login_page.dart';
import 'package:cafeite/screens/Home.dart';
import 'package:cafeite/screens/pesanansaya.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;
  String? _noHandphone;
  String? _status;
  int _selectedIndex = 2;

  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    Map<String, dynamic>? userDetails = await FireAuth.getUserDetails(_currentUser.uid);
    if (userDetails != null) {
      setState(() {
        _noHandphone = userDetails['noHandphone'];
        _status = userDetails['status'];
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('NAME: ${_currentUser.displayName}'),
            const SizedBox(height: 16.0),
            Text('EMAIL: ${_currentUser.email}'),
            const SizedBox(height: 16.0),
            Text('No Handphone: ${_noHandphone ?? "Loading..."}'), 
            const SizedBox(height: 16.0),
            Text('Status: ${_status ?? "Loading..."}'), 
            const SizedBox(height: 16.0),
            _currentUser.emailVerified
                ? Text('Email verified', style: TextStyle(color: Colors.green))
                : Text('Email not verified', style: TextStyle(color: Colors.red)),
            const SizedBox(height: 16.0),
            _isSendingVerification
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isSendingVerification = true;
                          });
                          await _currentUser.sendEmailVerification();
                          setState(() {
                            _isSendingVerification = false;
                          });
                        },
                        child: const Text('Verify email'),
                      ),
                      const SizedBox(width: 8.0),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () async {
                          User? user = await FireAuth.refreshUser(_currentUser);
                          if (user != null) {
                            setState(() {
                              _currentUser = user;
                            });
                          }
                        },
                      ),
                    ],
                  ),
            const SizedBox(height: 16.0),
            _isSigningOut
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isSigningOut = true;
                      });
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        _isSigningOut = false;
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Sign out'),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFF7EED3),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Pesanan Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Set the current index
        selectedItemColor: Colors.amber[800], // Change this to your desired color
        unselectedItemColor: Colors.grey, // Optional: Color for unselected items
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
          
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(user: widget.user),
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PesananSaya(user: widget.user),
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(user: widget.user),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}