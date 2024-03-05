import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_venturo/models/voucher.dart';
import '../models/menu.dart';

class Repository {
  final _baseUrl = 'https://tes-mobile.landa.id/api/';

  Future<List<Menu>> getListMenu() async {
    try {
      final response = await http.get(Uri.parse('${_baseUrl}menus'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> menuListJson = jsonData['datas'];
        return menuListJson.map((menuJson) => Menu.fromJson(menuJson)).toList();
      } else {
        throw Exception('Failed to load data list');
      }
    } catch (e) {
      throw Exception('Failed to load data list: $e');
    }
  }

  Future<Map<String, dynamic>> getVoucher(String kode) async {
    try {
      final response =
          await http.get(Uri.parse('${_baseUrl}vouchers?kode=${kode}'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        throw Exception('Failed to load voucher data');
      }
    } catch (e) {
      throw Exception('Failed to fetch voucher data: $e');
    }
  }

  Future<void> postOrder(String? voucherId, String nominalDiskon,
      String nominalPesanan, List<Map<String, dynamic>> items) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}order'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "voucher_id": voucherId,
          "nominal_diskon": nominalDiskon,
          "nominal_pesanan": nominalPesanan,
          "items": items,
        }),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // Handle response data if needed
        print('Order successful');
      } else {
        throw Exception('Failed to place order: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to place order: $e');
    }
  }

  Future postCancelOrder(int id) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}order/cancel/{${id}}'),
      );
      if (response.statusCode == 20) {
        final jsonData = jsonDecode(response.body);
        return Voucher.fromJson(jsonData);
      } else {
        throw Exception('Failed to Post Data');
      }
    } catch (e) {
      throw Exception('Failed to load data : $e');
    }
  }
}
