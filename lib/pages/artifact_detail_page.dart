import 'package:flutter/material.dart';
import '../models/artifact_model.dart';
import '../utils/utils.dart';

final url = '$urlBaseGlobal';

class ArtifactDetailPage extends StatelessWidget {
  final Artifact artifact;

  ArtifactDetailPage({required this.artifact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          artifact.name,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Imagen de fondo del artefacto
          Positioned.fill(
            child: artifact.imagePath != null
                ? Image.network(
                    url + artifact.imagePath!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 100,
                      ),
                    ),
                  ),
          ),
          // Superposición oscura para mejorar legibilidad
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Detalles del artefacto
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white.withOpacity(0.9),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nombre del artefacto
                        Text(
                          artifact.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Rareza máxima
                        Text(
                          'Max Rarity: ${artifact.maxRarity}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Bonificación de 2 piezas
                        if (artifact.twoPieceBonus != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              '2-Piece Bonus: ${artifact.twoPieceBonus}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        // Bonificación de 4 piezas
                        if (artifact.fourPieceBonus != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              '4-Piece Bonus: ${artifact.fourPieceBonus}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
