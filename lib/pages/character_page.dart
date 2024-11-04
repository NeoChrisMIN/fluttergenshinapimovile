// lib/pages/character_page.dart

import 'package:flutter/material.dart';
import '../widgets/character_list.dart';
import '../models/character_model.dart';
import 'artifact_page.dart';

class CharacterPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final List<Character> characters = [
    Character(name: 'Traveler', rarity: 5, imagePath: 'images/Icon_Paimon_Menu.png'),
    Character(name: 'Keqing', rarity: 5, imagePath: 'images/Icon_Paimon_Menu.png'),
    Character(name: 'Kaedehara Kazuha', rarity: 5, imagePath: 'images/Icon_Paimon_Menu.png'),
    Character(name: 'Kamisato Ayato', rarity: 5, imagePath: 'images/Icon_Paimon_Menu.png'),
    Character(name: 'Xiangling', rarity: 4, imagePath: 'images/Icon_Paimon_Menu.png'),
    Character(name: 'Xingqiu', rarity: 4, imagePath: 'images/Icon_Paimon_Menu.png'),
  ];
  

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    switch (_selectedIndex) {
      case 0:
        currentPage = CharacterList(characters: characters);
        break;
      case 1:
        currentPage = ArtifactPage();
        break;
      default:
        throw UnimplementedError('No widget for $_selectedIndex');
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Ajusta la altura según necesites
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Redondeo en las esquinas inferiores
          ),
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Image.asset(
                'images/Icon_Paimon_Menu.png',
                width: 30,
                height: 30,
              ),
            ),
            title: const Text(
              'Character Database',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.black87,
          ),
        ),
      ),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Character'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Artifacts'),
        ],
      ),
    );
  }
}
