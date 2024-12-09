import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../models/artifact_model.dart';
import '../models/team_model.dart';
import '../services/api_service.dart';
import '../utils/utils.dart';

class CharacterDetailPage extends StatefulWidget {
  final Character character;

  CharacterDetailPage({required this.character});

  @override
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

final url = '$urlBaseGlobal' + '/storage';

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  late Character characterData;
  late Future<List<Team>> futureTeams;
  final ApiService apiService = ApiService();

  double currentChildSize = 0.4;

  @override
  void initState() {
    super.initState();
    characterData = widget.character;
    futureTeams = apiService.fetchTeamsByCharacter(characterData.id);
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
      extendBodyBehindAppBar: true,
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color:
                  Colors.black.withOpacity(currentChildSize > 0.4 ? 0.5 : 0.0),
            ),
          ),
          // Detalle deslizable
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  setState(() {
                    currentChildSize = notification.extent;
                  });
                  return true;
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    url + characterData.iconBig,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (characterData.title != null)
                                    Text(
                                      characterData.title!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey,
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
                        const SizedBox(height: 20),
                        _buildSectionTitle("Artifacts"),
                        _buildArtifactsList(characterData.artifacts),
                        const SizedBox(height: 20),
                        _buildSectionTitle("Teams"),
                        _buildTeamsSection(),
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
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$label:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildArtifactsList(List<Artifact> artifacts) {
    if (artifacts.isEmpty) {
      return const Text(
        'No artifacts found.',
        style: TextStyle(fontSize: 16, color: Colors.white),
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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTeamsSection() {
    return FutureBuilder<List<Team>>(
      future: futureTeams,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text(
            "Error: ${snapshot.error}",
            style: const TextStyle(color: Colors.red),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text(
            'No teams found.',
            style: TextStyle(fontSize: 16, color: Colors.white),
          );
        } else {
          final teams = snapshot.data!;
          return Column(
            children: teams.map((team) {
              return Card(
                color: Colors.black.withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Text(
                        "Team: ${team.id}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10), // Reducido el espaciado
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight:
                              220, // Ajusta la altura mínima para el GridView
                          maxHeight: 300, // Altura máxima para evitar overflow
                        ),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          children: [
                            _buildCharacterCard("Main DPS", team.mainDps),
                            _buildCharacterCard("Sub DPS", team.subDps),
                            _buildCharacterCard("Support", team.support),
                            _buildCharacterCard(
                                "Healer/Shielder", team.healerShielder),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildCharacterCard(String role, Character character) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ajustar tamaño al contenido
      children: [
        // Role Text
        Card(
          color: Colors.white.withOpacity(0.1), // Fondo oscuro translúcido
          elevation: 2, // Pequeña sombra para diferenciarlo
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Bordes redondeados
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Espaciado interno
            child: Text(
              role,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texto en blanco
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Character Image with background
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              url + character.iconBig,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
