import 'package:flutter/material.dart';
import 'pages/character_page.dart';

void main() {
  runApp(GenshinWikiApp());
}

class GenshinWikiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genshin Wiki',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CharacterPage(),
    );
  }
}
