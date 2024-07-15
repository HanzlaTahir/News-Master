import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;

  ArticleDetailsScreen({Key? key, required this.article}) : super(key: key);

  void _saveArticle(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookmarks = prefs.getStringList('bookmarks') ?? [];
    bookmarks.add(jsonEncode(article.toJson()));
    await prefs.setStringList('bookmarks', bookmarks);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Article saved to bookmarks'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title!),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () => _saveArticle(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.urlToImage != null)
                Image.network(
                  article.urlToImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 20),
              Text(
                article.title!,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Source: ${article.source.name ?? "Unknown"}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                article.description ?? 'No description available',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ExpandableText(
                article.content ?? 'No content available',
                expandText: 'Show more',
                collapseText: 'Show less',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
