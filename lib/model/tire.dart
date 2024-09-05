import 'package:prolog/model/tire_current_retread.dart';
import 'package:prolog/model/tire_disposal.dart';
import 'package:prolog/model/tire_installed.dart';
import 'package:prolog/model/tire_make.dart';
import 'package:prolog/model/tire_model.dart';
import 'package:prolog/model/tire_size.dart';

class Tire {
  final int id;
  final String? serialNumber;
  final int? companyGroupId;
  final String? companyGroupName;
  final int? branchOfficeId;
  final String? branchOfficeName;
  final int? timesRetreaded;
  final int? maxRetreadsExpected;
  final dynamic? recommendedPressure;
  final dynamic? currentPressure;
  final String? dot;
  final dynamic? purchaseCost;
  final bool? newTire;
  final String? status;
  final DateTime? createdAt;
  final TireSize? tireSize;
  final TireMake? make;
  final TireModel? model;
  final TireCurrentRetread? currentRetread;
  final TireDisposal? disposal;
  final TireInstalled? installed;
  final List<dynamic>? registrationImages;

  final dynamic middleInnerTreadDepth;
  final dynamic outerTreadDepth;
  final dynamic middleOuterTreadDepth;
  final dynamic innerTreadDepth;

  Tire({
    required this.id,
    required this.serialNumber,
    required this.companyGroupId,
    required this.companyGroupName,
    required this.branchOfficeId,
    required this.branchOfficeName,
    required this.timesRetreaded,
    required this.maxRetreadsExpected,
    this.recommendedPressure,
    this.currentPressure,    
    required this.dot,
    this.purchaseCost,       
    required this.newTire,
    required this.status,
    required this.createdAt,
    required this.tireSize,
    required this.make,
    required this.model,
    this.currentRetread,
    this.disposal,
    this.installed,
    required this.registrationImages,
    this.middleInnerTreadDepth,
    this.outerTreadDepth,      
    this.middleOuterTreadDepth,
    this.innerTreadDepth,      
  });

  factory Tire.fromJson(Map<String, dynamic> json) {
    return Tire(
      id: json['id'],
      serialNumber: json['serialNumber'],
      companyGroupId: json['companyGroupId'],
      companyGroupName: json['companyGroupName'],
      branchOfficeId: json['branchOfficeId'],
      branchOfficeName: json['branchOfficeName'],
      timesRetreaded: json['timesRetreaded'],
      maxRetreadsExpected: json['maxRetreadsExpected'],
      recommendedPressure: json['recommendedPressure'],  
      currentPressure: json['currentPressure'],          
      dot: json['dot'] ?? '',
      purchaseCost: json['purchaseCost'],                
      newTire: json['newTire'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      tireSize: TireSize.fromJson(json['tireSize']),
      make: TireMake.fromJson(json['make']),
      model: TireModel.fromJson(json['model']),
      currentRetread: json['currentRetread'] != null
          ? TireCurrentRetread.fromJson(json['currentRetread'])
          : null,
      disposal: json['disposal'] != null ? TireDisposal.fromJson(json['disposal']) : null,
      installed: json['installed'] != null ? TireInstalled.fromJson(json['installed']) : null,
      registrationImages: json['registrationImages'] is List<dynamic>
          ? json['registrationImages']
          : [],
      middleInnerTreadDepth: json['middleInnerTreadDepth'],  
      outerTreadDepth: json['outerTreadDepth'],              
      middleOuterTreadDepth: json['middleOuterTreadDepth'],  
      innerTreadDepth: json['innerTreadDepth'],              
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serialNumber': serialNumber,
      'companyGroupId': companyGroupId,
      'companyGroupName': companyGroupName,
      'branchOfficeId': branchOfficeId,
      'branchOfficeName': branchOfficeName,
      'timesRetreaded': timesRetreaded,
      'maxRetreadsExpected': maxRetreadsExpected,
      'recommendedPressure': recommendedPressure,
      'currentPressure': currentPressure,
      'dot': dot,
      'purchaseCost': purchaseCost,
      'newTire': newTire,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'tireSize': tireSize?.toJson(),
      'make': make?.toJson(),
      'model': model?.toJson(),
      'currentRetread': currentRetread?.toJson(),
      'disposal': disposal?.toJson(),
      'installed': installed?.toJson(),
      'registrationImages': registrationImages,
      'middleInnerTreadDepth': middleInnerTreadDepth,
      'outerTreadDepth': outerTreadDepth,
      'middleOuterTreadDepth': middleOuterTreadDepth,
      'innerTreadDepth': innerTreadDepth,
    };
  }
}
