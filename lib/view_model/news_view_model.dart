import 'package:flutter_news/model/news_categories_model.dart';
import 'package:flutter_news/model/news_channel_headlines_model.dart';

import 'package:flutter_news/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelHeadlinesApi(channelName);
    return response;
  }

  Future<NewsCategoriesModel> fetchNewsCategoriesApi(String category) async {
    final response = await _rep.fetchNewsCategoriesApi(category);
    return response;
  }
}
