class Voucher {
  final int id;
  final String kode;
  final int nominal;
  final String created_at;
  final String updated_at;

  const Voucher({
    required this.id,
    required this.kode,
    required this.nominal,
    required this.created_at,
    required this.updated_at,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'kode': String kode,
        'nominal': int nominal,
        'created_at': String created_at,
        'updated_at': String updated_at
      } =>
        Voucher(
          id: id,
          kode: kode,
          nominal: nominal,
          created_at: created_at,
          updated_at: updated_at,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
