import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cafeite/config.dart';
import 'package:cafeite/model.dart';
import 'package:cafeite/restapi.dart';
import 'package:flutter/widgets.dart';

class MakananList extends StatefulWidget {
  const MakananList({Key? key}) : super(key: key);

  @override
  MakananListState createState() => MakananListState();
}

class MakananListState extends State<MakananList> {
  final searchKeyword = TextEditingController();
  bool searchStatus = false;

  DataService ds = DataService();

  List data = [];
  List<MakananModel> makanan = [];

  List<MakananModel> search_data = [];
  List<MakananModel> search_data_pre = [];

  selectAllMakananr() async {
    data = jsonDecode(await ds.selectAll(token, project, 'makanan', appid));

    makanan = data.map((e) => MakananModel.fromJson(e)).toList();

    setState(() {
      makanan = makanan;
    });
  }

  void filterMakanan(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      search_data = data.map((e) => MakananModel.fromJson(e)).toList();
    } else {
      search_data_pre = data.map((e) => MakananModel.fromJson(e)).toList();
      search_data = search_data_pre
          .where((user) => user.deskripsi
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      makanan = search_data;
    });
  }

  Future reloadDataMakanan(dynamic valye) async {
    setState(() {
      selectAllMakananr();
    });
  }

  @override
  void initState() {
    super.initState();
    selectAllMakananr();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CafeITe's Menu"),
        backgroundColor: Colors.brown[200],
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Aksi ketika ikon keranjang ditekan
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: filterMakanan,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.brown[50],
                hintText: 'Mau Makan Apa niiiih?',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
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
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Makanan Berat"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Filter Snack
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Snack"),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: makanan.length,
              itemBuilder: (context, index) {
                final item = makanan[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15.0),
                          ),
                          child: Image.asset(
                            item.imageurl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.nama_makanan,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item.harga,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: const Icon(Icons.add_circle),
                          color: Colors.brown,
                          onPressed: () {
                            // Aksi ketika tombol tambah ditekan
                          },
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Pesanan Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Aksi ketika item navigasi ditekan
        },
      ),
    );
  }

  Widget search_field() {
    return TextField(
      controller: searchKeyword,
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      textInputAction: TextInputAction.search,
      onChanged: (value) => filterMakanan(value),
      decoration: const InputDecoration(
        hintText: 'Enter to Search',
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 20,
        ),
      ),
    );
  }
}
