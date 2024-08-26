// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      name: json['name'] as String?,
      email: json['email'] as String?,
      status: json['status'] as String?,
      profile: json['profile'] as String?,
      about: json['about'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'status': instance.status,
      'profile': instance.profile,
      'about': instance.about,
      'userId': instance.userId,
    };
