import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final double subtotal;
  final double shippingFee;
  final double total;

  OrderTrackingPage({
    required this.orders,
    required this.subtotal,
    required this.shippingFee,
    required this.total,
    required String address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Tracking"),
        backgroundColor: Color(0xFFF7EED3),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pesanan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Image.asset(order['image'], width: 50),
                      title: Text(order['name']),
                      subtitle: Text("Catatan: ${order['note']}"),
                      trailing: Text("${order['quantity']}x"),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Makanan Sedang Dibuat"),
                RadioListTile(
                  value: 1,
                  groupValue: 2,
                  onChanged: (value) {},
                  title: Text("Makanan Sedang Diantar"),
                ),
                RadioListTile(
                  value: 3,
                  groupValue: 2,
                  onChanged: (value) {},
                  title: Text("Kurir Telah Sampai"),
                ),
                RadioListTile(
                  value: 4,
                  groupValue: 2,
                  onChanged: (value) {},
                  title: Text("Makanan Telah Selesai"),
                ),
              ],
            ),
            Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal Produk"),
                Text("Rp ${subtotal.toStringAsFixed(0)}"),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal Pengiriman"),
                Text("Rp ${shippingFee.toStringAsFixed(0)}"),
              ],
            ),
            Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Pembayaran",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp ${total.toStringAsFixed(0)}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
