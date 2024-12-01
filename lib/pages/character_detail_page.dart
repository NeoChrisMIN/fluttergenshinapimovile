import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../utils/utils.dart';

class CharacterDetailPage extends StatefulWidget {
  final Character character;

  CharacterDetailPage({required this.character});

  @override
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

final url = '$urlBaseGlobal';

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  late Character characterData;

  @override
  void initState() {
    super.initState();
    characterData = widget.character;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          characterData.name,
          style: const TextStyle(color: Colors.white), // Nombre en color blanco
        ),
        iconTheme:
            const IconThemeData(color: Colors.white), // Flecha en color blanco
        backgroundColor: Colors.transparent, // Fondo transparente
        elevation: 0,
      ),
      extendBodyBehindAppBar:
          true, // Para que el AppBar quede sobre el contenido
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.network(
              url + characterData.card,
              fit: BoxFit.cover,
            ),
          ),
          // Superposición oscura para legibilidad
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Tarjeta de detalles del personaje
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white.withOpacity(0.8), // Semi-transparente
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(url + characterData.iconBig),
                            radius: 30,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  characterData.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2, // Limitar a 2 líneas
                                  overflow:
                                      TextOverflow.ellipsis, // Mostrar "..."
                                ),
                                if (characterData.title != null)
                                  Text(
                                    characterData.title!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 2, // Limitar a 2 líneas
                                    overflow:
                                        TextOverflow.ellipsis, // Mostrar "..."
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      buildDetailText('Vision', characterData.vision),
                      buildDetailText('Weapon', characterData.weapon),
                      buildDetailText('Nation', characterData.nation),
                      buildDetailText('Affiliation', characterData.affiliation),
                      buildDetailText(
                          'Rarity', characterData.rarity.toString()),
                      buildDetailText(
                          'Constellations', characterData.constellation),
                      buildDetailText('Birthday', characterData.birthday),
                      buildDetailText('Description', characterData.description),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailText(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}
