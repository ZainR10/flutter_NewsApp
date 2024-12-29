import 'package:flutter/material.dart';

class ChannelProvider with ChangeNotifier {
  String _channelName = 'bbc-news';

  String get channelName => _channelName;

  void updateChannel(String newChannel) {
    _channelName = newChannel;
    notifyListeners();
  }
}
