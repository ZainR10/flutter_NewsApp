import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news/view_model/news_view_model.dart';
import 'package:intl/intl.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  NewsViewModel newsViewModel = NewsViewModel();

  final Format = DateFormat('MMMM,dd,yyyy');
  String categoryName = 'general';

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
    'Politics'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Text(categoriesList[index].toString()),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
