class Menu {
  final int id;
  final String nama;
  final int harga;
  final String tipe;
  final String gambar;
  int quantity;
  String catatan;

  Menu({
    required this.id,
    required this.nama,
    required this.harga,
    required this.tipe,
    required this.gambar,
    required this.quantity,
    required this.catatan,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'] as int,
      nama: json['nama'] as String,
      harga: json['harga'] as int,
      tipe: json['tipe'] as String,
      gambar: json['gambar'] as String,
      quantity: json['quantity'] ?? 0,
      catatan: json['catatan'] ?? "Tambahkan Catatan",
    );
  }
}
