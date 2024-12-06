class Weapon {
  final String id;
  final String name;
  final String type;
  final int rarity;
  final int baseAttack;
  final String subStat;
  final String passiveName;
  final String passiveDesc;
  final String location;
  final String ascensionMaterial;
  final String? image;

  Weapon({
    required this.id,
    required this.name,
    required this.type,
    required this.rarity,
    required this.baseAttack,
    required this.subStat,
    required this.passiveName,
    required this.passiveDesc,
    required this.location,
    required this.ascensionMaterial,
    this.image,
  });

  // Crear un objeto Weapon desde JSON
  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      rarity: json['rarity'] ?? 0,
      baseAttack: json['baseAttack'] ?? 0,
      subStat: json['subStat'] ?? '',
      passiveName: json['passiveName'] ?? '',
      passiveDesc: json['passiveDesc'] ?? '',
      location: json['location'] ?? '',
      ascensionMaterial: json['ascensionMaterial'] ?? '',
      image: json['image'],
    );
  }

  // Convertir un objeto Weapon a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'rarity': rarity,
      'baseAttack': baseAttack,
      'subStat': subStat,
      'passiveName': passiveName,
      'passiveDesc': passiveDesc,
      'location': location,
      'ascensionMaterial': ascensionMaterial,
      'image': image,
    };
  }
}