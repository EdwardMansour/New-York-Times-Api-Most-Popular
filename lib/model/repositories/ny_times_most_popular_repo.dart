import 'package:flutter/material.dart';
import 'package:ny_times/model/data/most_popular_news.dart';

import 'ny_times_serices.dart';

class NyTimesMostPopularRepo {
  final NyTimesServices nyTimesSerices;
  NyTimesMostPopularRepo({
    @required this.nyTimesSerices,
  }) : assert(nyTimesSerices != null);

  Future<MostPopularData> fetchNews(String section, int time) async {
    return await nyTimesSerices.fetchNews(section, time);
  }
}
