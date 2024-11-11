import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';
import '../pages/character_detail_page.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key, required List<Character> characters});

  @override
  // ignore: library_private_types_in_public_api
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  final ApiService apiService = ApiService();
  late Future<List<Character>> futureCharacters;

  @override
  void initState() {
    super.initState();
    futureCharacters = apiService.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Character>>(
      future: futureCharacters,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final characters = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return Card(
                color: Colors.grey[800],
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: Image.asset('assets/images/${character.id}.png'), // Ajusta el path de las imágenes
                  title: Text(
                    character.name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Rarity ${character.rarity}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailPage(character: character),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Center(child: Text("No se encontraron personajes"));
        }
      },
    );
  }
}
