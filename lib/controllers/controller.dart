import 'package:flutter/material.dart';
import 'package:test_venturo/models/voucher.dart';
import 'package:test_venturo/repository/repository.dart';

import '../models/menu.dart';

class MenusController extends ChangeNotifier {
  final Repository _repo = Repository();

  List<Menu> _menuList = [];
  List<Menu> get menuList => _menuList;
  int _totalBarang = 0;
  int get totalBarang => _totalBarang;

  String _catatan = 'Tambah catatan';
  String get catatan => _catatan;

  late Voucher _voucher;
  Voucher get voucher => _voucher;
  double _totalPrice = 0.0;
  double _subTotalPrice = 0.0;
  double get totalPrice => _totalPrice;
  double get subTotalPrice => _subTotalPrice;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  MenusController() {
    fetchDataMenu();
  }

  fetchDataMenu() async {
    try {
      List<Menu> menusList = await _repo.getListMenu();
      _menuList = List<Menu>.from(menusList);
      calculateTotalPrice();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch menu: $e');
    }
  }

  void increaseItem(Menu menu) {
    menu.quantity++;
    calculateTotalPrice();
    _totalBarang++;
    notifyListeners();
  }

  void decreaseItem(Menu menu) {
    menu.quantity = menu.quantity-- < 1 ? 0 : menu.quantity--;
    calculateTotalPrice();
    if (menu.quantity < 0) {
      menu.quantity = 0;
    }
    _totalBarang--;
    notifyListeners();
  }

  void calculateTotalPrice() {
    _totalPrice = 0;
    for (var element in _menuList) {
      _totalPrice += element.quantity * element.harga;
    }

    _subTotalPrice = 0;
    if (_totalPrice > 0) {
      _subTotalPrice = _totalPrice;
    }
    notifyListeners();
  }

  void fetchVoucher(String kode) async {
    try {
      Map<String, dynamic> voucherData = await _repo.getVoucher(kode);
      _voucher = Voucher.fromJson(voucherData['datas']);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch voucher: $e');
    }
  }

  void editCatatan(Menu menu, String newCatatan) {
    menu.catatan = newCatatan;
    notifyListeners();
  }

  Future<void> order(String? voucherId, String nominalDiskon,
      String nominalPesanan, List<Map<String, dynamic>> items) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _repo.postOrder("0", "0", nominalPesanan, items);
      print('Order successful');
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Failed to place order: $e');
    }
  }

  Future<void> cancelOrder(int id) async {
    try {
      await _repo.postCancelOrder(id);
      print('Order cancellation successful');
      // Lakukan tindakan setelah pembatalan pesanan berhasil
    } catch (e) {
      print('Failed to cancel order: $e');
    }
  }
}
