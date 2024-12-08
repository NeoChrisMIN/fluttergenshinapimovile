import 'character_model.dart';

class Team {
  final int id;
  final Character mainDps;
  final Character subDps;
  final Character support;
  final Character healerShielder;

  Team({
    required this.id,
    required this.mainDps,
    required this.subDps,
    required this.support,
    required this.healerShielder,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      mainDps: Character.fromJson(json['main_dps']),
      subDps: Character.fromJson(json['sub_dps']),
      support: Character.fromJson(json['support']),
      healerShielder: Character.fromJson(json['healer_shielder']),
    );
  }

  static List<Team> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Team.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main_dps': mainDps.toJson(),
      'sub_dps': subDps.toJson(),
      'support': support.toJson(),
      'healer_shielder': healerShielder.toJson(),
    };
  }
}
