import 'package:flutter/material.dart';
import 'package:cafeite/checkout_page.dart';

class CartItem {
  final String name;
  final String price;
  final String image;
  int quantity;
  bool isSelected;
  final String note;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
    this.isSelected = false,
    this.note = "",
  });
}

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;

  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double calculateTotalPrice() {
    return widget.cartItems.fold(0, (sum, item) {
      if (item.isSelected) {
        return sum +
            (double.parse(
                    item.price.replaceAll("Rp ", "").replaceAll(".", "")) *
                item.quantity);
      }
      return sum;
    });
  }

  void updateQuantity(int index, int change) {
    setState(() {
      widget.cartItems[index].quantity += change;
      if (widget.cartItems[index].quantity <= 0) {
        widget.cartItems.removeAt(index);
      }
    });
  }

  void toggleSelection(int index) {
    setState(() {
      widget.cartItems[index].isSelected = !widget.cartItems[index].isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang"),
        backgroundColor: Color(0xFFF7EED3),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = widget.cartItems[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Checkbox(
                        value: cartItem.isSelected,
                        onChanged: (value) {
                          toggleSelection(index);
                        }),
                    title: Text(cartItem.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cartItem.price),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                updateQuantity(index, -1);
                              },
                            ),
                            Text("${cartItem.quantity}"),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                updateQuantity(index, 1);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Image.asset(cartItem.image, width: 50),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TOTAL",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rp ${calculateTotalPrice().toStringAsFixed(0)}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                                  orders: widget.cartItems
                                      .where((item) => item.isSelected)
                                      .map((item) => {
                                            'name': item.name,
                                            'note':
                                                'Belum tersedia coy bingung',
                                            'image': item.image,
                                            'quantity': item.quantity,
                                          })
                                      .toList(),
                                  subtotal: calculateTotalPrice(),
                                  shippingFee: 3000,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8B0000),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text("Proses Pembayaran"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showAddToCartDialog(BuildContext context, Function onConfirm) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Konfirmasi"),
        content: Text("Apakah Anda ingin menambahkan menu ini ke keranjang?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Tidak"),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
            child: Text("Ya"),
          ),
        ],
      );
    },
  );
}