import 'dart:convert';

import 'package:flutter/foundation.dart';

class DietModel {
  List<String> daysData;
  DietModel({
    required this.daysData,
  });

  DietModel copyWith({
    List<String>? daysData,
  }) {
    return DietModel(
      daysData: daysData ?? this.daysData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'days': daysData,
    };
  }

  factory DietModel.fromMap(Map<String, dynamic> map) {
    return DietModel(
      daysData: List<String>.from(map['days']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DietModel.fromJson(String source) =>
      DietModel.fromMap(json.decode(source));

  @override
  String toString() => 'DietModel(days: $daysData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DietModel && listEquals(other.daysData, daysData);
  }

  @override
  int get hashCode => daysData.hashCode;
}
