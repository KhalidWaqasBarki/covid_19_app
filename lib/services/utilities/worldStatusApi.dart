import 'dart:convert';
import 'package:covid_19_app/model/WorldStatusMdl.dart';
import 'app_urls.dart';
import 'package:http/http.dart' as http;

class WorldStatusApi {
  static Future<WorldStatusModel> WorldStatus() async {
    final response = await http.get(Uri.parse(AppUrls.worldStatusApi));
    var data = await jsonDecode(response.body);
    WorldStatusModel worldStatusModel = WorldStatusModel.fromJson(data);
    return worldStatusModel;
  }

  static Future<List<dynamic>> CountriesListApi() async {
    final response = await http.get(Uri.parse(AppUrls.countrylist));
    var data = await jsonDecode(response.body);
    return data;
  }

}
