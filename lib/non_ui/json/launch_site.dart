import 'package:json_annotation/json_annotation.dart';

part 'launch_site.g.dart';

@JsonSerializable()
class LaunchSite {
  LaunchSite(this.siteId, this.siteName);

  @JsonKey(name: 'site_id')
  String siteId;
  @JsonKey(name: 'site_name')
  String siteName;

  factory LaunchSite.fromJson(Map<String, dynamic> json) =>
      _$LaunchSiteFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchSiteToJson(this);
}

//      "site_id":"ccafs_slc_40",
//      "site_name":"CCAFS SLC 40",
//      "site_name_long":"Cape Canaveral Air Force Station Space Launch Complex 40"
