// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_news/View/theme.dart';
// import 'package:flutter_news/View/themeprovider.dart';
// import 'package:flutter_news/model/search_model.dart';
// import 'package:flutter_news/view_model/news_view_model.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class SearchNews extends StatefulWidget {
//   const SearchNews({Key? key}) : super(key: key);

//   @override
//   State<SearchNews> createState() => _SearchNewsState();
// }

// NewsViewModel newsViewModel = NewsViewModel();

// class _SearchNewsState extends State<SearchNews> {
//   TextEditingController _searchController = TextEditingController();
//   List<Articles>? _searchResults;

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final width = MediaQuery.sizeOf(context).width * 1;
//     final height = MediaQuery.sizeOf(context).height * 1;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: _buildSearchField(),
//         actions: [],
//       ),
//       body: SafeArea(
//         child: _searchResults != null && _searchResults!.isNotEmpty
//             ? _buildSearchResults()
//             : _buildSearchFutureBuilder(),
//       ),
//     );
//   }

//   Widget _buildSearchField() {
//     return TextField(
//       controller: _searchController,
//       decoration: InputDecoration(
//         hintText: 'Search for news...',
//         suffixIcon: IconButton(
//           onPressed: () {
//             _searchNews(_searchController.text);
//           },
//           icon: Icon(Icons.search),
//         ),
//       ),
//     );
//   }

//   Future<void> _searchNews(String query) async {
//     try {
//       // Call your API or service to fetch search results
//       SearchModel searchResult = await newsViewModel.fetchSearchApi(query);
//       setState(() {
//         _searchResults = searchResult.articles;
//       });
//     } catch (e) {
//       print('Error searching news: $e');
//       // Handle error
//     }
//   }

//   Widget _buildSearchResults() {
//     return ListView.builder(
//       itemCount: _searchResults!.length,
//       itemBuilder: (context, index) {
//         Articles article = _searchResults![index];
//         return ListTile(
//           title: Text(article.title ?? ''),
//           subtitle: Text(article.description ?? ''),
//           // Handle tap on article
//           onTap: () {
//             // Handle tap on article
//           },
//         );
//       },
//     );
//   }

//   Widget _buildSearchFutureBuilder() {
//     return FutureBuilder<SearchModel>(
//       // Provide a future to fetch initial data for search results
//       future: _fetchInitialSearchData(),
//       builder: (context, AsyncSnapshot<SearchModel> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Return a loading indicator while data is being fetched
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           // Return an error message if there's an error
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (snapshot.hasData) {
//           // Access the retrieved data from the snapshot
//           List<Articles>? searchResults = snapshot.data!.articles;

//           // Return the search results once data is fetched successfully
//           return ListView.builder(
//             itemCount: searchResults!.length,
//             itemBuilder: (context, index) {
//               Articles article = searchResults[index];
//               return ListTile(
//                 title: Text(article.title ?? ''),
//                 subtitle: Text(article.description ?? ''),
//                 // Handle tap on article
//                 onTap: () {
//                   // Handle tap on article
//                 },
//               );
//             },
//           );
//         } else {
//           // Return a message if there's no data
//           return Center(child: Text('No data available'));
//         }
//       },
//     );
//   }
// }

// // Method to fetch initial data for search results
// Future<SearchModel> _fetchInitialSearchData() async {
//   // Call your API or service to fetch initial data for search results
//   return await newsViewModel.fetchSearchApi('');
// }
