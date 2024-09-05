class TireInstalled {
  final int vehicleId;
  final String licensePlate;
  final String fleetId;
  final int installedPosition;
  final String installedPositionName;

  TireInstalled({
    required this.vehicleId,
    required this.licensePlate,
    required this.fleetId,
    required this.installedPosition,
    required this.installedPositionName,
  });

  factory TireInstalled.fromJson(Map<String, dynamic> json) {
    return TireInstalled(
      vehicleId: json['vehicleId'] ?? 0,
      licensePlate: json['licensePlate'] ?? '',
      fleetId: json['fleetId'] ?? '',
      installedPosition: json['installedPosition'] ?? 0,
      installedPositionName: json['installedPositionName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleId': vehicleId,
      'licensePlate': licensePlate,
      'fleetId': fleetId,
      'installedPosition': installedPosition,
      'installedPositionName': installedPositionName,
    };
  }
}
