// lib/pages/character_page.dart

import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../widgets/character_list.dart';
import '../services/api_service.dart';
import 'artifact_page.dart';

class CharacterPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final ApiService apiService = ApiService();
  late Future<List<Character>> futureCharacters;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureCharacters = apiService.fetchCharacters(); // Cargamos los personajes desde la API
  }

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
        currentPage = FutureBuilder<List<Character>>(
          future: futureCharacters,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              return CharacterList(characters: snapshot.data!);
            } else {
              return Center(child: Text("No se encontraron personajes"));
            }
          },
        );
        break;
      case 1:
        currentPage = ArtifactPage();
        break;
      default:
        throw UnimplementedError('No widget para $_selectedIndex');
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
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
