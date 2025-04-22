import 'package:flutter/material.dart';

class DeveloperProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Developer Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(radius: 60, backgroundImage: AssetImage('assets/developer.jpg')),
            SizedBox(height: 20),
            Text("Name: John Doe"),
            Text("Class: DCS 5A"),
            Text("Age: 22"),
            Text("Education: Diploma in Computer Science"),
            SizedBox(height: 10),
            Text(
              "Background: A passionate mobile developer with a strong background in IoT and Flutter development. Experienced in building smart farming and automation systems.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
