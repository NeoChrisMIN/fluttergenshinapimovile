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
    );
  }
}
