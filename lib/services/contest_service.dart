import 'dart:convert';
import 'package:byteloop/model/contest_model.dart';
import 'package:http/http.dart' as http;

class ContestService {
  static const String baseUrl = "https://codeforces.com/api/contest.list";

  Future<List<ContestModel>> fetchContests({bool gym = false}) async {
    final uri = Uri.parse(
      baseUrl,
    ).replace(queryParameters: {if (gym) 'gym': 'true'});

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['status'] == 'OK') {
        final List data = body['result'];
        return data.map((e) => ContestModel.fromJson(e)).toList();
      } else {
        throw Exception('API failed: ${body['comment']}');
      }
    } else {
      throw Exception("HTTP Error: ${response.statusCode}");
    }
  }
}
