// import 'package:flutter/material.dart';
// import 'package:news_api_flutter_package/model/article.dart';
// import 'package:news_api_flutter_package/news_api_flutter_package.dart';
// import 'article_details_screen.dart';
//
// class NewsPage extends StatefulWidget {
//   const NewsPage({super.key});
//
//   @override
//   State<NewsPage> createState() => _NewsPageState();
// }
//
// class _NewsPageState extends State<NewsPage> {
//   late Future<List<Article>> future;
//   String? searchTerm;
//   bool isSearching = false;
//   TextEditingController searchController = TextEditingController();
//   List<String> categoryItems = [
//     "GENERAL",
//     "BUSINESS",
//     "ENTERTAINMENT",
//     "HEALTH",
//     "SCIENCE",
//     "SPORTS",
//     "TECHNOLOGY",
//   ];
//
//   late String selectedCategory;
//
//   @override
//   void initState() {
//     selectedCategory = categoryItems[0];
//     future = getNewsData();
//
//     super.initState();
//   }
//
//   Future<List<Article>> getNewsData() async {
//     NewsAPI newsAPI = NewsAPI("a0de37813e69491e9fb19ec6d7c79545");
//     return await newsAPI.getTopHeadlines(
//       country: "us",
//       query: searchTerm,
//       category: selectedCategory,
//       pageSize: 50,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: isSearching ? searchAppBar() : appBar(),
//       body: SafeArea(
//           child: Column(
//             children: [
//               _buildCategories(),
//               Expanded(
//                 child: FutureBuilder(
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     } else if (snapshot.hasError) {
//                       return const Center(
//                         child: Text("Error loading the news"),
//                       );
//                     } else {
//                       if (snapshot.hasData &&
//                           (snapshot.data as List<Article>).isNotEmpty) {
//                         return _buildNewsListView(snapshot.data as List<Article>);
//                       } else {
//                         return const Center(
//                           child: Text("No news available"),
//                         );
//                       }
//                     }
//                   },
//                   future: future,
//                 ),
//               )
//             ],
//           )),
//     );
//   }
//
//   searchAppBar() {
//     return AppBar(
//       backgroundColor: Colors.green,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: () {
//           setState(() {
//             isSearching = false;
//             searchTerm = null;
//             searchController.text = "";
//             future = getNewsData();
//           });
//         },
//       ),
//       title: TextField(
//         controller: searchController,
//         style: const TextStyle(color: Colors.white),
//         cursorColor: Colors.white,
//         decoration: const InputDecoration(
//           hintText: "Search",
//           hintStyle: TextStyle(color: Colors.white70),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.transparent),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.transparent),
//           ),
//         ),
//       ),
//       actions: [
//         IconButton(
//             onPressed: () {
//               setState(() {
//                 searchTerm = searchController.text;
//                 future = getNewsData();
//               });
//             },
//             icon: const Icon(Icons.search)),
//       ],
//     );
//   }
//
//   appBar() {
//     return AppBar(
//       backgroundColor: Colors.green,
//       title: const Text("NEWS NOW"),
//       actions: [
//         IconButton(
//             onPressed: () {
//               setState(() {
//                 isSearching = true;
//               });
//             },
//             icon: const Icon(Icons.search)),
//       ],
//     );
//   }
//
//   Widget _buildNewsListView(List<Article> articleList) {
//     return ListView.builder(
//       itemBuilder: (context, index) {
//         Article article = articleList[index];
//         return _buildNewsItem(article);
//       },
//       itemCount: articleList.length,
//     );
//   }
//
//   Widget _buildNewsItem(Article article) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ArticleDetailsScreen(article: article),
//             ));
//       },
//       child: Card(
//         elevation: 4,
//         child: Padding(
//           padding: EdgeInsets.all(8),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 80,
//                 width: 80,
//                 child: Image.network(
//                   article.urlToImage ?? "",
//                   fit: BoxFit.fitHeight,
//                   errorBuilder: (context, error, stackTrace) {
//                     return const Icon(Icons.image_not_supported);
//                   },
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         article.title!,
//                         maxLines: 2,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       Text(
//                         article.source.name!,
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategories() {
//     return SizedBox(
//       height: 60,
//       child: ListView.builder(
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedCategory = categoryItems[index];
//                   future = getNewsData();
//                 });
//               },
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                     categoryItems[index] == selectedCategory
//                         ? Colors.green.withOpacity(0.5)
//                         : Colors.green,
//                   )),
//               child: Text(categoryItems[index]),
//             ),
//           );
//         },
//         itemCount: categoryItems.length,
//         scrollDirection: Axis.horizontal,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:news1_1/ui/navbar.dart';
// import 'package:news_api_flutter_package/model/article.dart';
// import 'package:news_api_flutter_package/news_api_flutter_package.dart';
// import '../../article_details_screen.dart';
//
// class NewsPage extends StatefulWidget {
//   const NewsPage({Key? key}) : super(key: key);
//
//   @override
//   State<NewsPage> createState() => _NewsPageState();
// }
//
// class _NewsPageState extends State<NewsPage> {
//   late Future<List<Article>> future;
//   String? searchTerm;
//   bool isSearching = false;
//   TextEditingController searchController = TextEditingController();
//   List<String> categoryItems = [
//     "GENERAL",
//     "BUSINESS",
//     "ENTERTAINMENT",
//     "HEALTH",
//     "SCIENCE",
//     "SPORTS",
//     "TECHNOLOGY",
//   ];
//
//   late String selectedCategory;
//
//   @override
//   void initState() {
//     selectedCategory = categoryItems[0];
//     future = getNewsData();
//
//     super.initState();
//   }
//
//   Future<List<Article>> getNewsData() async {
//     NewsAPI newsAPI = NewsAPI(apiKey: "a0de37813e69491e9fb19ec6d7c79545");
//     return await newsAPI.getTopHeadlines(
//       country: "us",
//       query: searchTerm,
//       category: selectedCategory,
//       pageSize: 50,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: isSearching ? searchAppBar() : appBar(),
//       drawer: Drawer(
//         child:
//             NavBar(), // Assuming NavBar is implemented in the navbar.dart file
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildCategories(),
//             Expanded(
//               child: FutureBuilder(
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (snapshot.hasError) {
//                     return const Center(
//                       child: Text("Error loading the news"),
//                     );
//                   } else {
//                     if (snapshot.hasData &&
//                         (snapshot.data as List<Article>).isNotEmpty) {
//                       return _buildNewsListView(snapshot.data as List<Article>);
//                     } else {
//                       return const Center(
//                         child: Text("No news available"),
//                       );
//                     }
//                   }
//                 },
//                 future: future,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   AppBar searchAppBar() {
//     return AppBar(
//       backgroundColor: Colors.deepPurple,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: () {
//           setState(() {
//             isSearching = false;
//             searchTerm = null;
//             searchController.clear();
//             future = getNewsData();
//           });
//         },
//       ),
//       title: TextField(
//         controller: searchController,
//         style: const TextStyle(color: Colors.white),
//         cursorColor: Colors.white,
//         decoration: const InputDecoration(
//           hintText: "Search",
//           hintStyle: TextStyle(color: Colors.white70),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.transparent),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.transparent),
//           ),
//         ),
//         onChanged: (value) {
//           setState(() {
//             searchTerm = value.isEmpty ? null : value;
//             future = getNewsData();
//           });
//         },
//       ),
//       actions: [
//         IconButton(
//           onPressed: () {
//             setState(() {
//               searchTerm = searchController.text;
//               future = getNewsData();
//             });
//           },
//           icon: const Icon(Icons.search),
//         ),
//       ],
//     );
//   }
//
//   AppBar appBar() {
//     return AppBar(
//       automaticallyImplyLeading: true,
//       // This property controls whether to show the leading widget automatically
//       backgroundColor: Colors.black12,
//       title: const Text("NEWS MASTER"),
//       centerTitle: true,
//       leading: Builder(
//         builder: (BuildContext context) {
//           return IconButton(
//             icon: Icon(Icons.menu), // This is the hamburger icon
//             onPressed: () {
//               Scaffold.of(context)
//                   .openDrawer(); // This opens the drawer when the icon is clicked
//             },
//           );
//         },
//       ),
//       actions: [
//         IconButton(
//           onPressed: () {
//             setState(() {
//               isSearching = true;
//             });
//           },
//           icon: const Icon(Icons.search),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildNewsListView(List<Article> articleList) {
//     return ListView.builder(
//       itemBuilder: (context, index) {
//         Article article = articleList[index];
//         return _buildNewsItem(article);
//       },
//       itemCount: articleList.length,
//     );
//   }
//
//   Widget _buildNewsItem(Article article) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ArticleDetailsScreen(article: article),
//           ),
//         );
//       },
//       child: Card(
//         elevation: 4,
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 80,
//                 width: 80,
//                 child: Image.network(
//                   article.urlToImage ?? "",
//                   fit: BoxFit.fitHeight,
//                   errorBuilder: (context, error, stackTrace) {
//                     return const Icon(Icons.image_not_supported);
//                   },
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       article.title!,
//                       maxLines: 2,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     Text(
//                       article.source.name!,
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategories() {
//     return SizedBox(
//       height: 60,
//       child: ListView.builder(
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedCategory = categoryItems[index];
//                   future = getNewsData();
//                 });
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                   categoryItems[index] == selectedCategory
//                       // ? Colors.green.withOpacity(0.5)
//                       // : Colors.green,
//                       ? Colors.yellow.shade300
//                       : Colors.white10,
//                 ),
//               ),
//               child: Text(categoryItems[index]),
//             ),
//           );
//         },
//         itemCount: categoryItems.length,
//         scrollDirection: Axis.horizontal,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:news1_1/ui/navbar.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import '../../article_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<Article>> future;
  String? searchTerm;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<String> categoryItems = [
    "GENERAL",
    "BUSINESS",
    "ENTERTAINMENT",
    "HEALTH",
    "SCIENCE",
    "SPORTS",
    "TECHNOLOGY",
  ];

  late String selectedCategory;

  @override
  void initState() {
    selectedCategory = categoryItems[0];
    future = getNewsData();
    super.initState();
  }

  Future<List<Article>> getNewsData() async {
    NewsAPI newsAPI = NewsAPI(apiKey: "a0de37813e69491e9fb19ec6d7c79545");
    return await newsAPI.getTopHeadlines(
      country: "us",
      query: searchTerm,
      category: selectedCategory,
      pageSize: 50,
    );
  }

  void _saveArticle(Article article) async {
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
      appBar: isSearching ? searchAppBar() : appBar(),
      drawer: Drawer(
        child: NavBar(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildCategories(),
            Expanded(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error loading the news"),
                    );
                  } else {
                    if (snapshot.hasData &&
                        (snapshot.data as List<Article>).isNotEmpty) {
                      return _buildNewsListView(snapshot.data as List<Article>);
                    } else {
                      return const Center(
                        child: Text("No news available"),
                      );
                    }
                  }
                },
                future: future,
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar searchAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            isSearching = false;
            searchTerm = null;
            searchController.clear();
            future = getNewsData();
          });
        },
      ),
      title: TextField(
        controller: searchController,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        onChanged: (value) {
          setState(() {
            searchTerm = value.isEmpty ? null : value;
            future = getNewsData();
          });
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              searchTerm = searchController.text;
              future = getNewsData();
            });
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.black12,
      title: const Text("NEWS MASTER"),
      centerTitle: true,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = true;
            });
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _buildNewsListView(List<Article> articleList) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Article article = articleList[index];
        return _buildNewsItem(article);
      },
      itemCount: articleList.length,
    );
  }

  Widget _buildNewsItem(Article article) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailsScreen(article: article),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(
                  article.urlToImage ?? "",
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title!,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      article.source.name!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.bookmark),
                onPressed: () => _saveArticle(article),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedCategory = categoryItems[index];
                  future = getNewsData();
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  categoryItems[index] == selectedCategory
                      ? Colors.yellow.shade300
                      : Colors.white10,
                ),
              ),
              child: Text(categoryItems[index]),
            ),
          );
        },
        itemCount: categoryItems.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:news_api_flutter_package/model/article.dart';
// import 'package:news_api_flutter_package/news_api_flutter_package.dart';
// import '../../article_details_screen.dart';
//
// class NewsPage extends StatefulWidget {
//   const NewsPage({Key? key}) : super(key: key);
//
//   @override
//   State<NewsPage> createState() => _NewsPageState();
// }
//
// class _NewsPageState extends State<NewsPage> {
//   late Future<List<Article>> future;
//   String? searchTerm;
//   bool isSearching = false;
//   TextEditingController searchController = TextEditingController();
//   List<String> categoryItems = [
//     "GENERAL",
//     "BUSINESS",
//     "ENTERTAINMENT",
//     "HEALTH",
//     "SCIENCE",
//     "SPORTS",
//     "TECHNOLOGY",
//   ];
//
//   late String selectedCategory;
//
//   @override
//   void initState() {
//     selectedCategory = categoryItems[0];
//     future = getNewsData();
//
//     super.initState();
//   }
//
//   Future<List<Article>> getNewsData() async {
//     NewsAPI newsAPI = NewsAPI(apiKey: "a0de37813e69491e9fb19ec6d7c79545");
//     return await newsAPI.getTopHeadlines(
//       country: "us",
//       query: searchTerm,
//       category: selectedCategory,
//       pageSize: 50,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(),
//       drawer: Drawer(
//         child: ListView(
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.green,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundImage: NetworkImage(
//                       'https://example.com/your-image.jpg', // Replace with your image URL
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Your Name',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.image),
//               title: Text('Image'),
//               onTap: () {
//                 // Handle image option
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.brightness_4),
//               title: Text('Dark Mode'),
//               onTap: () {
//                 // Handle dark mode option
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.star),
//               title: Text('Rate this app'),
//               onTap: () {
//                 // Handle rate this app option
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.privacy_tip),
//               title: Text('Privacy Policy'),
//               onTap: () {
//                 // Handle privacy policy option
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.info),
//               title: Text('About Us'),
//               onTap: () {
//                 // Handle about us option
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.notifications),
//               title: Text('Get Notifications'),
//               onTap: () {
//                 // Handle get notifications option
//               },
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildCategories(),
//             Expanded(
//               child: FutureBuilder(
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (snapshot.hasError) {
//                     return const Center(
//                       child: Text("Error loading the news"),
//                     );
//                   } else {
//                     if (snapshot.hasData &&
//                         (snapshot.data as List<Article>).isNotEmpty) {
//                       return _buildNewsListView(snapshot.data as List<Article>);
//                     } else {
//                       return const Center(
//                         child: Text("No news available"),
//                       );
//                     }
//                   }
//                 },
//                 future: future,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   AppBar appBar() {
//     return AppBar(
//       backgroundColor: Colors.green,
//       leading: IconButton(
//         icon: Icon(Icons.menu),
//         onPressed: () {
//           Scaffold.of(context).openDrawer();
//         },
//         color: Colors.white,
//       ),
//       title: const Text("NEWS MASTER"),
//       centerTitle: true,
//       actions: [
//         IconButton(
//           onPressed: () {
//             setState(() {
//               isSearching = true;
//             });
//           },
//           icon: const Icon(Icons.search),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildNewsListView(List<Article> articleList) {
//     return ListView.builder(
//       itemBuilder: (context, index) {
//         Article article = articleList[index];
//         return _buildNewsItem(article);
//       },
//       itemCount: articleList.length,
//     );
//   }
//
//   Widget _buildNewsItem(Article article) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ArticleDetailsScreen(article: article),
//           ),
//         );
//       },
//       child: Card(
//         elevation: 4,
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 80,
//                 width: 80,
//                 child: Image.network(
//                   article.urlToImage ?? "",
//                   fit: BoxFit.fitHeight,
//                   errorBuilder: (context, error, stackTrace) {
//                     return const Icon(Icons.image_not_supported);
//                   },
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       article.title!,
//                       maxLines: 2,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     Text(
//                       article.source.name!,
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategories() {
//     return SizedBox(
//       height: 60,
//       child: ListView.builder(
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedCategory = categoryItems[index];
//                   future = getNewsData();
//                 });
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                   categoryItems[index] == selectedCategory
//                       ? Colors.green.withOpacity(0.5)
//                       : Colors.green,
//                 ),
//               ),
//               child: Text(categoryItems[index]),
//             ),
//           );
//         },
//         itemCount: categoryItems.length,
//         scrollDirection: Axis.horizontal,
//       ),
//     );
//   }
// }
