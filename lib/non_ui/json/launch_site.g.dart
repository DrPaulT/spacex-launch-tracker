// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_site.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchSite _$LaunchSiteFromJson(Map<String, dynamic> json) {
  return LaunchSite(
    json['site_id'] as String,
    json['site_name'] as String,
  );
}

Map<String, dynamic> _$LaunchSiteToJson(LaunchSite instance) =>
    <String, dynamic>{
      'site_id': instance.siteId,
      'site_name': instance.siteName,
    };
