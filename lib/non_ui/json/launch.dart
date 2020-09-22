import 'package:json_annotation/json_annotation.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch_site.dart';

part 'launch.g.dart';

@JsonSerializable()
class Launch {
  Launch(this.missionName, this.launchDateUnix, this.launchSite);

  @JsonKey(name: 'mission_name')
  String missionName;
  @JsonKey(name: 'launch_date_unix')
  int launchDateUnix;
  @JsonKey(name: 'launch_site')
  LaunchSite launchSite;

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchToJson(this);
}

//  {
//    "mission_name":"SAOCOM 1B, GNOMES-1, Tyvak-0172",
//    "launch_date_unix":1598829480,
//    "launch_site":{
//      "site_id":"ccafs_slc_40",
//      "site_name":"CCAFS SLC 40",
//      "site_name_long":"Cape Canaveral Air Force Station Space Launch Complex 40"
//    }
//  }
