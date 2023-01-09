import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PageData {
  String title;
  String image;
  String description;
  String courseDuration;
  PageData({
    required this.title,
    required this.image,
    required this.description,
    required this.courseDuration,
  });

  PageData copyWith({
    String? title,
    String? image,
    String? description,
    String? courseDuration,
  }) {
    return PageData(
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      courseDuration: courseDuration ?? this.courseDuration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'description': description,
      'courseDuration': courseDuration,
    };
  }

  factory PageData.fromMap(Map<String, dynamic> map) {
    return PageData(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      courseDuration: map['courseDuration'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PageData.fromJson(String source) =>
      PageData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PageData(title: $title, image: $image, description: $description, courseDuration: $courseDuration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PageData &&
        other.title == title &&
        other.image == image &&
        other.description == description &&
        other.courseDuration == courseDuration;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        image.hashCode ^
        description.hashCode ^
        courseDuration.hashCode;
  }
}

class PageDetailsProvider extends ChangeNotifier {
  List<PageData> pageData = [
    PageData(
      title: "Diet Recommendation",
      image: "assets/icons/Hamburger.svg",
      courseDuration: "3-10 Minutes",
      description:
          "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
    ),
    PageData(
      title: "Exercise",
      image: "assets/icons/Excrecises.svg",
      courseDuration: "3-10 Minutes",
      description:
          "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
    ),
    PageData(
      title: "Meditation",
      image: "assets/icons/Meditation.svg",
      courseDuration: "3-10 Minutes",
      description:
          "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
    ),
    PageData(
      title: "Yoga",
      image: "assets/icons/yoga.svg",
      courseDuration: "3-10 Minutes",
      description:
          "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
    ),
  ];
}
