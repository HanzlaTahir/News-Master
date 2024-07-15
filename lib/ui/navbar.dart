import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news1_1/ui/Provider/theme_changer_provider.dart';
import 'package:news1_1/ui/auth/login_screen.dart';
import 'package:news1_1/ui/bookmarks_page.dart';
import 'package:news1_1/ui/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_us_page.dart';

class NavBar extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  final List<Map<String, String>> newsWebsites = [
    {'name': 'BBC News', 'url': 'https://www.bbc.com/news'},
    {'name': 'Google News', 'url': 'https://news.google.com'},
    {'name': 'AP News', 'url': 'https://apnews.com'},
    {'name': 'NBC News', 'url': 'https://www.nbcnews.com/'},
  ];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchEmail() async {
    final User? user = auth.currentUser;
    final String userEmail = user?.email ?? '';
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'newsmaster@gmail.com',
      query: 'subject=About News Master&body=From: ',
    );

    if (!await launchUrl(emailUri)) {
      throw 'Could not launch $emailUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage('images/splash.jpeg')),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'General Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.bookmark_border),
              title: Text('Bookmarks'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookmarksPage(),
                    ))
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              trailing: Consumer<ThemeChanger>(
                builder: (context, themeChanger, _) => Switch(
                  value: themeChanger.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    ThemeMode newTheme =
                        value ? ThemeMode.dark : ThemeMode.light;
                    themeChanger.setTheme(newTheme);
                  },
                ),
              ),
              leading: Icon(Icons.dark_mode),
              title: Text('Dark Mode'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              leading: Icon(Icons.read_more_outlined),
              title: Text('More Channels'),
              children: newsWebsites.map((website) {
                return ListTile(
                  title: Text(website['name']!),
                  onTap: () => _launchURL(website['url']!),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              leading: Icon(Icons.help_center_outlined),
              title: Text('About Us'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUs()),
                )
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              leading: Icon(Icons.contact_mail),
              title: Text('Contact Us'),
              onTap: () async {
                try {
                  await _launchEmail();
                } catch (e) {
                  print('Error launching email: $e');
                }
              },
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 10.0,
            thickness: 2.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.logout_rounded),
              title: Text('Logout'),
              onTap: () => {
                auth.signOut().then((value) {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                      .onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                })
              },
            ),
          ),
        ],
      ),
    );
  }
}
