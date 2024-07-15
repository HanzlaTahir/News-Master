import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'dart:convert';
import 'package:news1_1/article_details_screen.dart';

class BookmarksPage extends StatefulWidget {
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  List<Article> _bookmarkedArticles = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarkedArticles();
  }

  void _loadBookmarkedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookmarks = prefs.getStringList('bookmarks') ?? [];
    setState(() {
      _bookmarkedArticles =
          bookmarks.map((e) => Article.fromJson(jsonDecode(e))).toList();
    });
  }

  void _removeBookmark(Article article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookmarks = prefs.getStringList('bookmarks') ?? [];
    bookmarks.removeWhere(
        (element) => Article.fromJson(jsonDecode(element)).url == article.url);
    await prefs.setStringList('bookmarks', bookmarks);
    setState(() {
      _bookmarkedArticles.remove(article);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Article removed from bookmarks'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
      ),
      body: ListView.builder(
        itemCount: _bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = _bookmarkedArticles[index];
          return ListTile(
            title: Text(article.title!),
            subtitle: Text(article.source.name!),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeBookmark(article),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailsScreen(article: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
