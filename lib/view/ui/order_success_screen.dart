import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controllers/controller.dart';

class OrderSuccessScreen extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const OrderSuccessScreen({Key? key, required this.items}) : super(key: key);

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  void _showEditNoteDialog(
      BuildContext context, String itemName, Function(String) save) {
    TextEditingController _controller = TextEditingController();
    _controller.text = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Catatan untuk $itemName'),
          content: TextField(
            controller: _controller,
            onChanged: (value) {},
            decoration: InputDecoration(hintText: 'Masukkan catatan di sini'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                save(_controller.text);
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Widget _bottomAppBar(BuildContext context) {
    MenusController _menusController = Provider.of<MenusController>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.25,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          color: Color(0xFFF6F6F6),
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Total Pesanan ",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "(${_menusController.totalBarang} Menu) :",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Rp ${_menusController.subTotalPrice}",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF009AAD),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Divider(
                    color: const Color.fromARGB(255, 189, 188, 188),
                    thickness: 0.2,
                    height: 14,
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  CupertinoIcons.ticket,
                                  color: Color(0xFF009AAD),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Voucher",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Input Voucher",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2E2E2E),
                                  ),
                                ),
                                Icon(
                                  Icons.navigate_next,
                                  color: Color(0xFF2E2E2E),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Container(
                    width: screenWidth,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_basket,
                              color: Color(0xFF009AAD),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Pembayaran",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2E2E2E),
                                    ),
                                  ),
                                  Text(
                                    "Rp ${_menusController.totalPrice}",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF009AAD),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text("Order Berhasil"),
                                content: Text(
                                    "Apakah Anda ingin melihat detail pesanan Anda?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Tidak"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        await _menusController.cancelOrder(0);
                                        print('Pesanan berhasil dibatalkan');
                                        Navigator.of(context).pop();
                                      } catch (e) {
                                        print('Gagal membatalkan pesanan: $e');
                                      }
                                      ;
                                    },
                                    child: Text("Ya"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: _menusController.isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    "Batalkan",
                                  ),
                          ),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: Color(0xFF00717F),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                  color: Color(0xFF00717F), width: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MenusController _menusController = Provider.of<MenusController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      leading: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 64,
                          height: 64,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              '${widget.items[index]['gambar']}',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                      title: Expanded(
                        child: Text(
                          widget.items[index]['nama'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2E2E2E),
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rp ${widget.items[index]['harga']}',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF009AAD),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notes,
                                color: Color(0xFF009AAD),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.items[index]['catatan'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Center(
                        child: Text('${widget.items[index]['quantity']}'),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: widget.items.length,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: _bottomAppBar(context),
      ),
    );
  }
}
