import 'package:flutter_test/flutter_test.dart';
import 'package:fluttergenshinapimovile/models/team_model.dart';
import 'package:fluttergenshinapimovile/models/character_model.dart';

void main() {
  group('Team Tests', () {
    test('Model creation test', () {
      final model = Team(
        id: 1,
        mainDps: Character(id: '1', name: 'Main DPS', rarity: 5),
        subDps: Character(id: '2', name: 'Sub DPS', rarity: 4),
        support: Character(id: '3', name: 'Support', rarity: 4),
        healerShielder: Character(id: '4', name: 'Healer', rarity: 5),
      );
      expect(model, isNotNull);
    });

    test('JSON serialization test', () {
      final model = Team(
        id: 1,
        mainDps: Character(id: '1', name: 'Main DPS', rarity: 5),
        subDps: Character(id: '2', name: 'Sub DPS', rarity: 4),
        support: Character(id: '3', name: 'Support', rarity: 4),
        healerShielder: Character(id: '4', name: 'Healer', rarity: 5),
      );
      final json = model.toJson();
      final newModel = Team.fromJson(json);
      expect(newModel, isA<Team>());
    });
  });
}
