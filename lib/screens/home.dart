import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafeite/utils/fire_auth.dart';

import 'package:cafeite/screens/pesanansaya.dart';
import 'package:cafeite/screens/profile_page.dart';
import 'package:cafeite/config.dart';
import 'package:cafeite/utils/model.dart';
import 'package:cafeite/utils/restapi.dart';


class HomePage extends StatefulWidget {
  final User user;
  @override

  const HomePage({super.key, required this.user});
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? _noHandphone;
  String? _status;

  int _selectedIndex = 0;

  late User _currentUser;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _fetchUserDetails();

    _pages = [
      ProfilePage(user: _currentUser), 
    ];
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

  final List<Map<String, String>> menuItems = [
    {
      'name': 'Beng Beng',
      'price': 'Rp 2.000',
      'pict': 'assets_snack/bengbeng.jpg',
    },
    {
      'name': 'Ayam Goreng',
      'price': 'Rp 25.000',
      'pict': 'assets_snack/ayam_goreng.jpg',
    },
    {
      'name': 'Mie Goreng',
      'price': 'Rp 15.000',
      'pict': 'assets_snack/mie_goreng.jpg',
    },
    {
      'name': 'Es Teh',
      'price': 'Rp 5.000',
      'pict': 'assets_snack/es_teh.jpg',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: (value) {
          print("Filter: $value");
          // Tambahkan fungsi filter jika diperlukan
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF7EED3),
          hintText: 'Mau Makan Apa niiiih?',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFF7EED3),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              "CafeITe's Menu",
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                print('Keranjang di tekan');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          searchField(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Filter Makanan Berat
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B0000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.fastfood,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Makanan Berat",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Filter Snack
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Snack"),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 13,
                mainAxisSpacing: 8.0,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 4.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8.0),
                        ),
                        child: Image.asset(
                          item["pict"]!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item["name"]!,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item["price"]!,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                print("${item["name"]} ditambahkan");
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
      currentIndex: _selectedIndex, 
      selectedItemColor: Colors.amber[800], 
      unselectedItemColor: Colors.grey, 
      onTap: (index) {
        setState(() {
          _selectedIndex = index; 
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
        }
      )
    );
  }
}
