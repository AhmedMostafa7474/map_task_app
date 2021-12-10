import 'package:http/http.dart' as http;
class Destination_web_services
{
  Future<String> GetAllPlaces(String Url)async
  {
    try{
    var response=await http.get(Uri.parse(Url),
        headers: <String,String>
    {
      "Content-Type":"application/json"
    });
    return response.body;

  }catch(e)
    {
      return "";
    }

  }
}