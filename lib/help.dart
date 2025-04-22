import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help & Support")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text("FAQs", style: Theme.of(context).textTheme.titleLarge),
          ListTile(title: Text("How to connect to the system?")),
          ListTile(title: Text("How to control the irrigation pump?")),
          ListTile(title: Text("How to read sensor data?")),
          SizedBox(height: 20),
          Text("Contact Support", style: Theme.of(context).textTheme.titleLarge),
          ListTile(title: Text("Email: support@smartfarm.com")),
          ListTile(title: Text("Phone: +6012-3456789")),
          SizedBox(height: 20),
          Text("Video Tutorials", style: Theme.of(context).textTheme.titleLarge),
          ListTile(title: Text("1. Getting Started")),
          ListTile(title: Text("2. Using the Dashboard")),
        ],
      ),
    );
  }
}
