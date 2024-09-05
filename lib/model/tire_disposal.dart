class TireDisposal {
  final int disposalReasonId;
  final String disposalReasonDescription;
  final List<String> disposalImagesUrl;

  TireDisposal({
    required this.disposalReasonId,
    required this.disposalReasonDescription,
    required this.disposalImagesUrl,
  });

  factory TireDisposal.fromJson(Map<String, dynamic> json) {
    return TireDisposal(
      disposalReasonId: json['disposalReasonId'],
      disposalReasonDescription: json['disposalReasonDescription'],
      disposalImagesUrl: List<String>.from(json['disposalImagesUrl']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disposalReasonId': disposalReasonId,
      'disposalReasonDescription': disposalReasonDescription,
      'disposalImagesUrl': disposalImagesUrl,
    };
  }
}
