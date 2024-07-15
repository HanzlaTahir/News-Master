import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('About the Associated Press',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'The Associated Press (AP) is a U.S.-based not-for-profit news agency headquartered in New York City. The AP is owned by its contributing newspapers, radio, and television stations in the United States, all of which contribute stories to the AP and use material written by its staff journalists.',
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Terms and Conditions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'These terms and conditions outline the rules and regulations for the use of our app. By accessing this app we assume you accept these terms and conditions. Do not continue to use News Master if you do not agree to take all of the terms and conditions stated on this page.',
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Privacy Policy',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Your privacy is important to us. It is News Master\'s policy to respect your privacy regarding any information we may collect from you across our app, News Master, and other sites we own and operate.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
