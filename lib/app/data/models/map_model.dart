part of "models.dart";

class MapModel {
  final String display_name;
  final double lat;
  final double lon;

  MapModel({required this.display_name, required this.lat, required this.lon});

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      display_name: json['display_name'],
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'display_name': display_name,
      'lon': lon,
      'lat': lat,
    };
  }
}
