import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../widgets/character_list.dart';
import '../services/api_service.dart';
import '../widgets/artifact_list_page.dart';
import '../widgets/weapon_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  late Future<List<Character>> futureCharacters;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureCharacters =
        apiService.fetchCharacters(); // Cargamos los personajes desde la API
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    String appBarTitle;

    switch (_selectedIndex) {
      case 0:
        appBarTitle = 'Character Database';
        currentPage = FutureBuilder<List<Character>>(
          future: futureCharacters,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              return CharacterList();
            } else {
              return const Center(child: Text("No se encontraron personajes"));
            }
          },
        );
        break;
      case 1:
        appBarTitle = 'Artifact Database';
        currentPage = ArtifactListPage();
        break;
      case 2:
        appBarTitle = 'Weapon Database';
        currentPage = WeaponListPage();
        break;
      default:
        throw UnimplementedError('No widget para $_selectedIndex');
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: ClipRRect(
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Image.asset(
                'images/Icon_Paimon_Menu.png',
                width: 30,
                height: 30,
              ),
            ),
            title: Text(
              appBarTitle,
              style: const TextStyle(color: Colors.white),
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
          BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'Weapons'),
        ],
      ),
    );
  }
}
