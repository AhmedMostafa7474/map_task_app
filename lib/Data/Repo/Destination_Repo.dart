import 'dart:convert';

import 'package:map_task_app/Data/Models/Destination.dart';
import 'package:map_task_app/Data/Web_Services/Destination_web_services.dart';

class Destination_Repo
{
  final Destination_web_services _destination_web_services;

  Destination_Repo(this._destination_web_services);
  Future<List<Destination>>GetAllPlaces(String Url)
  async
  {
    var body=await _destination_web_services.GetAllPlaces(Url);
    var jsonResponse=json.decode(body) as List<dynamic>;
    return jsonResponse.map((e) => Destination.fromJson(e)).toList();
  }
}