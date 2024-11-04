// lib/widgets/character_list.dart

import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../pages/character_detail_page.dart';

class CharacterList extends StatelessWidget {
  final List<Character> characters;

  const CharacterList({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return Card(
          color: Colors.grey[800],
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: Image.asset(character.imagePath), 
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
  }
}
