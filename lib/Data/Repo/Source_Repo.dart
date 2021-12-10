import 'package:map_task_app/Data/Models/Source.dart';
import 'package:map_task_app/Data/Web_Services/Source_web_services.dart';

class Source_Repo
{
 final Source_web_services _source_web_services;

  Source_Repo(this._source_web_services);

  Future <List<Source>>GetFirstPlaces()async{
    var body =await _source_web_services.GetFirstplaces();
    return body.map((e) => Source.fromJson(e.data())).toList();
  }
 Future <List<Source>>GetNextPlaces()async{
   var body =await _source_web_services.GetNextplaces();
   return body.map((e) => Source.fromJson(e.data())).toList();
 }
}