import 'dart:convert';
import 'dart:io'; // Import for SocketException
import 'package:flutter_news/model/news_categories_model.dart';
import 'package:flutter_news/model/news_channel_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=f268e96207244b1abf8c5aa984769405';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return NewsChannelHeadlinesModel.fromJson(body);
      } else {
        throw Exception('Failed to load news headlines');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }

  Future<NewsCategoriesModel> fetchNewsCategoriesApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=f268e96207244b1abf8c5aa984769405';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return NewsCategoriesModel.fromJson(body);
      } else {
        throw Exception('Failed to load news categories');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }
}
