import 'dart:convert';

class Source {
  Source({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  String name;
  double latitude;
  double longitude;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    name: json["name"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
  };

  static Map<String, dynamic> toMap(Source source) => {
    'name': source.name,
    'latitude': source.latitude,
    'longitude': source.longitude,
  };

 static String encode(Source source) => json.encode(
    Source.toMap(source)
  );

  static List<Source> decode(String source) =>
      (json.decode(source) as List<dynamic>)
          .map<Source>((item) => Source.fromJson(item))
          .toList();
}

Source sourceFromJson(String? str) => Source.fromJson(json.decode(str!));

String sourceToJson(Source data) => json.encode(data.toJson());

