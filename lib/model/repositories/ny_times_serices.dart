import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ny_times/core/dependency-injection.dart';
import 'package:ny_times/model/data/most_popular_news.dart';

class NyTimesServices {
  //todo based url
  final _basedUrl = 'https://api.nytimes.com';
  //todo: token key of my account
  final _tokenKey = 'VKbSZ1UyoIHASQnpnT3fF4yFAWx63HX0';
  final Dio dio;
  NyTimesServices({
    @required this.dio,
  }) : assert(dio != null);

  //todo: get the most populare news
  Future<MostPopularData> fetchNews(String section, int time) async {
    final url = '$_basedUrl/svc/mostpopular/v2/mostviewed/$section/$time.json';
    var response = await dio.get(
      '$url',
      queryParameters: {
        "api-key": _tokenKey,
      },
      options: sl(),
    );
    final rawData = jsonDecode(jsonEncode(response.data));
    var data = MostPopularData.fromJson(rawData);

    return data;
  }
}
