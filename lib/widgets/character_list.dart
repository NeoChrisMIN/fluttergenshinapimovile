
import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';
import '../pages/character_detail_page.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key, required List<Character> characters});

  @override
  _CharacterListState createState() => _CharacterListState();
}

//final baseUrl = "http://192.168.100.30:8000/storage/images/characters/albedo/icon-big.png";

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
                  //leading: SizedBox(width: 20,height: 20, child: Scaffold(body: Image.network(baseUrl),backgroundColor: Colors.black12,),),
                  leading: SizedBox(width: 50, height: 50, child: character.iconBig.isNotEmpty
                      ? Image.network(character.iconBig, width: 50, height: 50, fit: BoxFit.cover)
                      : Icon(Icons.image_not_supported, color: Colors.grey),),
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
