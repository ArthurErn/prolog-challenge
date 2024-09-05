class TireModel {
  final int id;
  final String name;
  final int groovesQuantity;
  final double treadDepth;

  TireModel({
    required this.id,
    required this.name,
    required this.groovesQuantity,
    required this.treadDepth,
  });

  factory TireModel.fromJson(Map<String, dynamic> json) {
    return TireModel(
      id: json['id'],
      name: json['name'],
      groovesQuantity: json['groovesQuantity'],
      treadDepth: json['treadDepth'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'groovesQuantity': groovesQuantity,
      'treadDepth': treadDepth,
    };
  }
}
