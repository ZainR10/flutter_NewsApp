import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_news/model/news_channel_headlines_model.dart';

class NewsRepository {
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    String url =
        'https://newsapi.org/v2/everything?q=bitcoin&apiKey=f268e96207244b1abf8c5aa984769405';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('error');
  }
}
