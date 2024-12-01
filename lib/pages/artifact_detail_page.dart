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
      appBar: AppBar(
        title: Text(
          widget.artifact.name,
          style: TextStyle(
            color: currentChildSize > 0.4 ? Colors.white : Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: currentChildSize > 0.4 ? Colors.white : Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
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
          // Superposición oscura dinámica para mejorar la legibilidad
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color:
                  Colors.black.withOpacity(currentChildSize > 0.4 ? 0.5 : 0.0),
            ),
          ),
          // Tarjeta deslizable con detalles del artefacto
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
                    color: Colors.white.withOpacity(0.9),
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
                        // Nombre del artefacto
                        Text(
                          widget.artifact.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Rareza máxima
                        Text(
                          'Max Rarity: ${widget.artifact.maxRarity}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Bonificación de 2 piezas
                        if (widget.artifact.twoPieceBonus != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              '2-Piece Bonus: ${widget.artifact.twoPieceBonus}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        // Bonificación de 4 piezas
                        if (widget.artifact.fourPieceBonus != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              '4-Piece Bonus: ${widget.artifact.fourPieceBonus}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
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
}
