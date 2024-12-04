import 'package:flutter/material.dart';
import '../models/artifact_model.dart';
import '../utils/utils.dart';

final url = '$urlBaseGlobal';

class ArtifactDetailPage extends StatefulWidget {
  final Artifact artifact;

  ArtifactDetailPage({required this.artifact});

  @override
  _ArtifactDetailPageState createState() => _ArtifactDetailPageState();
}

class _ArtifactDetailPageState extends State<ArtifactDetailPage> {
  double currentChildSize = 0.4; // Tamaño inicial de la tarjeta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Imagen de fondo global
          Positioned.fill(
            child: Image.asset(
              'images/fondo.png', // Imagen de fondo
              fit: BoxFit.cover,
            ),
          ),
          // Imagen de fondo del artefacto
          Positioned.fill(
            child: widget.artifact.imagePath != null
                ? Image.network(
                    url + widget.artifact.imagePath!,
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
          // Superposición oscura para legibilidad
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: Colors.black
                  .withOpacity(currentChildSize > 0.4 ? 0.5 : 0.0), // Dinámico
            ),
          ),
          // Detalles deslizable
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
                        Text(
                          widget.artifact.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        buildDetailText(
                            'Max Rarity', widget.artifact.maxRarity.toString()),
                        if (widget.artifact.twoPieceBonus != null)
                          buildDetailText(
                              '2-Piece Bonus', widget.artifact.twoPieceBonus!),
                        if (widget.artifact.fourPieceBonus != null)
                          buildDetailText(
                              '4-Piece Bonus', widget.artifact.fourPieceBonus!),
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

  Widget buildDetailText(String label, String value) {
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
}
