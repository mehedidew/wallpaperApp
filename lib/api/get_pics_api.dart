import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/api/links.dart';
import 'package:wallpaper_app/model/pic_model.dart';

class GetPicApi {
  final int pageCount;
  List<PicModel> pics = [];
  var jsonData;

  GetPicApi({required this.pageCount});

  Future<List<PicModel>> fetch() async {
    try {
      var url = Uri.parse('${Links.baseUrl}page=$pageCount&limit=10');
      http.Response response = await http.get(url);

      jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var i in jsonData) {
          pics.add(PicModel.fromJson(i));
        }

      }
    } catch (e, s) {
      print('Get pics api catchBlock $e');
    }
    return pics;
  }
}
