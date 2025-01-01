import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafeite/screens/profile_page.dart';
import 'package:cafeite/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cafeite/utils/fire_auth.dart';

class PesananSaya extends StatefulWidget {
  final User user;

  const PesananSaya({super.key, required this.user});

  @override
  _PesananSayaState createState() => _PesananSayaState();
}

class _PesananSayaState extends State<PesananSaya> {
  int _selectedIndex = 1;
  late User _currentUser;
  late Stream<QuerySnapshot> _ordersStream;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _ordersStream = FirebaseFirestore.instance
        .collection('orders') 
        .where('userId', isEqualTo: _currentUser.uid) 
        .snapshots();
  }

  Widget buildOrderCard(String title, String subtitle, String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    height: 100, 
                    width: 100,  
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8.0), // Space between image and text
                Expanded( // Allow the text to take the remaining space
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle button press action
                print("Button pressed for $title!");
              },
              child: Text("Action"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFF7EED3),
        title: const Text("CafeITe's Menu"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return Center(child: Text("No orders found."));
          }

          return SingleChildScrollView(
            child: Column(
              children: orders.map((order) {
                final data = order.data() as Map<String, dynamic>;
                return buildOrderCard(
                  data['title'] ?? 'No Title',
                  data['subtitle'] ?? 'No Subtitle',
                  data['imageUrl'] ?? 'assets/images/sample_image.jpg', // Default image
                );
              }).toList(),
            ),
          );
        },
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
        },
      ),
    );
  }
}