import 'tire_make.dart';
import 'tire_model.dart';

class TireCurrentRetread {
  final TireMake make;
  final TireModel model;
  final double retreadCost;

  TireCurrentRetread({
    required this.make,
    required this.model,
    required this.retreadCost,
  });

  factory TireCurrentRetread.fromJson(Map<String, dynamic> json) {
    return TireCurrentRetread(
      make: TireMake.fromJson(json['make']),
      model: TireModel.fromJson(json['model']),
      retreadCost: json['retreadCost'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'make': make.toJson(),
      'model': model.toJson(),
      'retreadCost': retreadCost,
    };
  }
}
