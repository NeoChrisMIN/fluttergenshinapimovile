import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../models/artifact_model.dart';
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
  double currentChildSize = 0.4; // Tamaño actual de la tarjeta

  @override
  void initState() {
    super.initState();
    characterData = widget.character;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: currentChildSize > 0.4 ? Colors.white : Colors.black,
        ),
        backgroundColor: Colors.transparent,
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
          // Superposición oscura para legibilidad, dinámica según el tamaño
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color:
                  Colors.black.withOpacity(currentChildSize > 0.4 ? 0.5 : 0.0),
            ),
          ),
          // Detalle deslizable
          DraggableScrollableSheet(
            initialChildSize: 0.4, // Tamaño inicial de la tarjeta
            minChildSize: 0.2, // Tamaño mínimo al deslizar hacia abajo
            maxChildSize: 0.85, // Tamaño máximo al deslizar hacia arriba
            builder: (context, scrollController) {
              return NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  setState(() {
                    currentChildSize = notification.extent;
                  });
                  return true;
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.9), // Fondo semi-transparente
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
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
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (characterData.title != null)
                                    Text(
                                      characterData.title!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[700],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle("Details"),
                        buildDetailText('Vision', characterData.vision),
                        buildDetailText('Weapon', characterData.weapon),
                        buildDetailText('Nation', characterData.nation),
                        buildDetailText(
                            'Affiliation', characterData.affiliation),
                        buildDetailText(
                            'Rarity', characterData.rarity.toString()),
                        const SizedBox(height: 10),
                        _buildSectionTitle("Artifacts"),
                        _buildArtifactsList(characterData.artifacts),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDetailText(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildArtifactsList(List<Artifact> artifacts) {
    if (artifacts.isEmpty) {
      return const Text(
        'No artifacts found.',
        style: TextStyle(fontSize: 16, color: Colors.black87),
      );
    }

    return Column(
      children: artifacts.map((artifact) {
        return ListTile(
          leading: artifact.imagePath != null
              ? Image.network(
                  url + artifact.imagePath!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                ),
          title: Text(
            artifact.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }
}
