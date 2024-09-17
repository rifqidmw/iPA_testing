import 'dart:convert';

import 'package:base_flutter/presentation/resources/assets_manager.dart';


class OnboardingModel {
  final String image;
  final String title;
  final String description;
  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });

  OnboardingModel copyWith({
    String? image,
    String? title,
    String? description,
  }) {
    return OnboardingModel(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'description': description,
    };
  }

  factory OnboardingModel.fromMap(Map<String, dynamic> map) {
    return OnboardingModel(
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingModel.fromJson(String source) => OnboardingModel.fromMap(json.decode(source));

  @override
  String toString() => 'OnboardingModel(image: $image, title: $title, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OnboardingModel &&
      other.image == image &&
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode => image.hashCode ^ title.hashCode ^ description.hashCode;
}

var dummyOnboardingList = [
  OnboardingModel(image: ImageAssets.sampleOnboarding1, title: 'Hello 1', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non consectetur turpis. Morbi eu eleifend lacus.'),
  OnboardingModel(image: ImageAssets.sampleOnboarding2, title: 'Hello 2', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non consectetur turpis. Morbi eu eleifend lacus.'),
  OnboardingModel(image: ImageAssets.sampleOnboarding3, title: 'Hello 3', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non consectetur turpis. Morbi eu eleifend lacus.'),
  OnboardingModel(image: ImageAssets.sampleOnboarding4, title: 'Ready?', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
];
