import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_details_model.g.dart';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

@immutable
@JsonSerializable()
class UserProfile {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "profile")
  final String? profile;
  @JsonKey(name: "about")
  final String? about;
  @JsonKey(name: "userId")
  final String? userId;

  UserProfile({
    this.name,
    this.email,
    this.status,
    this.profile,
    this.about,
    this.userId,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? status,
    String? profile,
    String? about,
    String? userId,
  }) =>
      UserProfile(
        name: name ?? this.name,
        email: email ?? this.email,
        status: status ?? this.status,
        profile: profile ?? this.profile,
        about: about ?? this.about,
        userId: userId ?? this.userId,
      );

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
