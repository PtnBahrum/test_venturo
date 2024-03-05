class Order {
  final String status_code;
  final String message;

  const Order({required this.status_code, required this.message});

  factory Order.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'status_code': String status_code,
        'message': String message,
      } =>
        Order(
          status_code: status_code,
          message: message,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
