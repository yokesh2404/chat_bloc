// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'api_response.g.dart';

List<ApiResponse> apiResponseFromJson(String str) => List<ApiResponse>.from(
    json.decode(str).map((x) => ApiResponse.fromJson(x)));

String apiResponseToJson(List<ApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class ApiResponse {
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "body")
  final String? body;

  ApiResponse({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  ApiResponse copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) =>
      ApiResponse(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
      );

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
