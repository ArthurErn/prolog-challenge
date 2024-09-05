class TireMake {
  final int id;
  final String name;

  TireMake({
    required this.id,
    required this.name,
  });

  factory TireMake.fromJson(Map<String, dynamic> json) {
    return TireMake(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
