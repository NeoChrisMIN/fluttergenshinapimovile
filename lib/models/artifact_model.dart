import 'dart:convert';

class Artifact {
  final String id;
  final String name;
  final int maxRarity;
  final String? twoPieceBonus;
  final String? fourPieceBonus;
  final String? imagePath;

  Artifact({
    required this.id,
    required this.name,
    required this.maxRarity,
    this.twoPieceBonus,
    this.fourPieceBonus,
    this.imagePath,
  });

  // Crear un objeto Artifact desde JSON
  factory Artifact.fromJson(Map<String, dynamic> json) {
    return Artifact(
      id: json['id'].toString(), // Forzar id como string
      name: json['name'],
      maxRarity: json['max_rarity'],
      twoPieceBonus: json['2_piece_bonus'],
      fourPieceBonus: json['4_piece_bonus'],
      imagePath: json['image_path'],
    );
  }

  // Convertir un objeto Artifact a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'max_rarity': maxRarity,
      '2_piece_bonus': twoPieceBonus,
      '4_piece_bonus': fourPieceBonus,
      'image_path': imagePath,
    };
  }
}
