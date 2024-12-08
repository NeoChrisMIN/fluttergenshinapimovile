import 'artifact_model.dart';

class Character {
  final String id;
  final String name;
  final String title;
  final String vision;
  final String weapon;
  final String gender;
  final String nation;
  final String affiliation;
  final int rarity;
  final String release;
  final String constellation;
  final String birthday;
  final String description;
  final String card;
  final String iconBig;
  final List<Artifact> artifacts; // Lista de artefactos asociados

  Character({
    required this.id,
    required this.name,
    this.title = 'Unknown',
    this.vision = 'Unknown',
    this.weapon = 'Unknown',
    this.gender = 'Unknown',
    this.nation = 'Unknown',
    this.affiliation = 'Unknown',
    required this.rarity,
    this.release = 'Unknown',
    this.constellation = 'Unknown',
    this.birthday = 'Unknown',
    this.description = 'No description available',
    this.card = '',
    this.iconBig = '',
    this.artifacts = const [], // Valor predeterminado: lista vacía
  });

  // Factory constructor para crear un objeto Character desde JSON
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] ?? 'Unknown',
      name: json['name'] ?? 'Unknown',
      title: json['title'] ?? 'Unknown',
      vision: json['vision'] ?? 'Unknown',
      weapon: json['weapon'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      nation: json['nation'] ?? 'Unknown',
      affiliation: json['affiliation'] ?? 'Unknown',
      rarity: json['rarity'] ?? 0,
      release: json['release'] ?? 'Unknown',
      constellation: json['constellation'] ?? 'Unknown',
      birthday: json['birthday'] ?? 'Unknown',
      description: json['description'] ?? 'No description available',
      card: json['card'] ?? '',
      iconBig: json['icon_big'] ?? '',
      artifacts: (json['artifacts'] as List<dynamic>?)
              ?.map((artifactJson) => Artifact.fromJson(artifactJson))
              .toList() ??
          [], // Convierte los artefactos desde JSON
    );
  }

  // Método para procesar un listado paginado
  static List<Character> fromPaginatedJson(Map<String, dynamic> json) {
    final List<dynamic> characterData = json['data'] ?? [];
    return characterData.map((item) => Character.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'vision': vision,
      'weapon': weapon,
      'gender': gender,
      'nation': nation,
      'affiliation': affiliation,
      'rarity': rarity,
      'release': release,
      'constellation': constellation,
      'birthday': birthday,
      'description': description,
      'card': card,
      'icon_big': iconBig,
      'artifacts': artifacts.map((artifact) => artifact.toJson()).toList(),
    };
  }

}
