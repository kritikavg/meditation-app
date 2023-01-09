import 'dart:convert';

import 'package:flutter/foundation.dart';

class ExcersiseModel {
  String title;
  String description;
  String duration;
  List<String> sessions;
  ExcersiseModel({
    required this.title,
    required this.description,
    required this.duration,
    required this.sessions,
  });
  

  ExcersiseModel copyWith({
    String? title,
    String? description,
    String? duration,
    List<String>? sessions,
  }) {
    return ExcersiseModel(
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      sessions: sessions ?? this.sessions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'duration': duration,
      'sessions': sessions,
    };
  }

  factory ExcersiseModel.fromMap(Map<String, dynamic> map) {
    return ExcersiseModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      duration: map['duration'] ?? '',
      sessions: List<String>.from(map['sessions']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExcersiseModel.fromJson(String source) => ExcersiseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExcersiseModel(title: $title, description: $description, duration: $duration, sessions: $sessions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExcersiseModel &&
      other.title == title &&
      other.description == description &&
      other.duration == duration &&
      listEquals(other.sessions, sessions);
  }

  @override
  int get hashCode {
    return title.hashCode ^
      description.hashCode ^
      duration.hashCode ^
      sessions.hashCode;
  }
}
