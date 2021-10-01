import 'dart:convert';

import 'package:coinedone/models/data.dart';
import 'package:http/http.dart' as http;

abstract class DataRepository {
  Future<Data> getData();
}

class DataRepositoryImpl implements DataRepository {
  @override
  Future<Data> getData() async {
    final response = await http.get(
      'https://api.mocklets.com/mock68182/screentime',
    );
    if (response.statusCode == 200) {
      print(response.body);
      List data = json.decode(response.body);
      Data dashbaordData = Data.fromJson(data[0]);
      print(dashbaordData);
      return dashbaordData;
    } else {
      throw Exception();
    }
  }
}
