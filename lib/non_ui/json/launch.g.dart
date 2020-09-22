// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Launch _$LaunchFromJson(Map<String, dynamic> json) {
  return Launch(
    json['mission_name'] as String,
    json['launch_date_unix'] as int,
    json['launch_site'] == null
        ? null
        : LaunchSite.fromJson(json['launch_site'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
      'mission_name': instance.missionName,
      'launch_date_unix': instance.launchDateUnix,
      'launch_site': instance.launchSite,
    };
