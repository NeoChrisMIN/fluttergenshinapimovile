
import 'package:flutter/material.dart';
import '../models/character_model.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  CharacterDetailPage({required this.character});

  @override
  Widget build(BuildContext context) {
    final cardImageUrl = character.card;
    final cardImageUrlIcon = character.iconBig;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: cardImageUrl.isNotEmpty
                  ? Image.network(cardImageUrl, fit: BoxFit.cover)
                  : Container(color: Colors.grey, child: Center(child: Icon(Icons.image_not_supported, size: 50))),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: cardImageUrlIcon.isNotEmpty
                              ? NetworkImage(cardImageUrlIcon)
                              : NetworkImage(cardImageUrlIcon),
                          radius: 30.0,
                          child: cardImageUrlIcon.isEmpty
                              ? Icon(Icons.person, size: 30)
                              : null,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          character.name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          character.title, // Muestra el título del personaje
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    character.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Rarity: ${character.rarity}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  // Agrega más detalles según sea necesario
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
