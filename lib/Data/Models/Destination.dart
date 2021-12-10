import 'dart:convert';

class Destination {
  Destination({
    required this.country,
    required  this.name,
    required this.lat,
    required this.lng,
  });

  String country;
  String name;
  String lat;
  String lng;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    country: json["country"],
    name: json["name"],
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "name": name,
    "lat": lat,
    "lng": lng,
  };
}
Destination destinationFromJson(String? str) => Destination.fromJson(json.decode(str!));

String destinationToJson(Destination data) => json.encode(data.toJson());
