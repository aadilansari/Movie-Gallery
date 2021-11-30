import 'dart:convert';

import 'package:flutter_task/model.dart';
import 'package:http/http.dart' as http;

Future<Search> fetchSearch() async {
  final response = await http.get(Uri.parse(
      'http://www.omdbapi.com/?i=tt3896198&apikey=c4033450&s=Movies'));

  if (response.statusCode == 200) {
    return Search.fromJson(jsonDecode(response.body));

    /*  List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Search.fromJson(data)).toList(); */
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
