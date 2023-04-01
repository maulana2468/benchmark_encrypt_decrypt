// To parse this JSON data, do
//
//     final internPositionResponse = internPositionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

InternPositionResponse internPositionResponseFromJson(String str) =>
    InternPositionResponse.fromJson(json.decode(str));

String internPositionResponseToJson(InternPositionResponse data) =>
    json.encode(data.toJson());

class InternPositionResponse {
  InternPositionResponse({
    required this.data,
    required this.meta,
  });

  final List<InternPosition> data;
  final Meta meta;

  factory InternPositionResponse.fromJson(Map<String, dynamic> json) =>
      InternPositionResponse(
        data: List<InternPosition>.from(
            json["data"].map((x) => InternPosition.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class InternPosition extends Equatable {
  const InternPosition({
    required this.id,
    required this.name,
    required this.activityName,
    required this.total,
    required this.startDuration,
    required this.endDuration,
    required this.startRegistration,
    required this.endRegistration,
    required this.creditsCount,
    required this.activityType,
    required this.location,
    required this.locationKotakabCode,
    required this.mitraId,
    required this.certified,
    required this.logo,
    required this.mitraName,
    required this.publishedTime,
  });

  final String id;
  final String name;
  final String activityName;
  final int total;
  final DateTime startDuration;
  final DateTime endDuration;
  final DateTime startRegistration;
  final DateTime endRegistration;
  final int creditsCount;
  final String activityType;
  final String location;
  final String locationKotakabCode;
  final String mitraId;
  final bool certified;
  final String logo;
  final String mitraName;
  final DateTime publishedTime;

  factory InternPosition.fromJson(Map<String, dynamic> json) => InternPosition(
        id: json["id"],
        name: json["name"],
        activityName: json["activity_name"],
        total: json["total"],
        startDuration: DateTime.parse(json["start_duration"]),
        endDuration: DateTime.parse(json["end_duration"]),
        startRegistration: DateTime.parse(json["start_registration"]),
        endRegistration: DateTime.parse(json["end_registration"]),
        creditsCount: json["credits_count"],
        activityType: json["activity_type"],
        location: json["location"],
        locationKotakabCode: json["location_kotakab_code"],
        mitraId: json["mitra_id"],
        certified: json["certified"],
        logo: json["logo"],
        mitraName: json["mitra_name"],
        publishedTime: DateTime.parse(json["published_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "activity_name": activityName,
        "total": total,
        "start_duration": startDuration.toIso8601String(),
        "end_duration": endDuration.toIso8601String(),
        "start_registration": startRegistration.toIso8601String(),
        "end_registration": endRegistration.toIso8601String(),
        "credits_count": creditsCount,
        "activity_type": activityType,
        "location": location,
        "location_kotakab_code": locationKotakabCode,
        "mitra_id": mitraId,
        "certified": certified,
        "logo": logo,
        "mitra_name": mitraName,
        "published_time": publishedTime.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        activityName,
        total,
        startDuration,
        endDuration,
        startRegistration,
        endRegistration,
        creditsCount,
        activityType,
        location,
        locationKotakabCode,
        mitraId,
        certified,
        logo,
        mitraName,
        publishedTime,
      ];
}

class Meta {
  Meta({
    required this.limit,
    required this.offset,
    required this.total,
  });

  final int limit;
  final int offset;
  final int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        limit: json["limit"],
        offset: json["offset"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "total": total,
      };
}
