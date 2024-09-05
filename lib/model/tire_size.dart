class TireSize {
  final int id;
  final double height;
  final double width;
  final double rim;

  TireSize({
    required this.id,
    required this.height,
    required this.width,
    required this.rim,
  });

  factory TireSize.fromJson(Map<String, dynamic> json) {
    return TireSize(
      id: json['id'],
      height: json['height'].toDouble(),
      width: json['width'].toDouble(),
      rim: json['rim'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'height': height,
      'width': width,
      'rim': rim,
    };
  }
}
