import 'package:flutter_test/flutter_test.dart';
import 'package:fluttergenshinapimovile/models/character_model.dart';
import 'package:fluttergenshinapimovile/models/artifact_model.dart';

void main() {
  group('Character Tests', () {
    test('Model creation test', () {
      final model = Character(
        id: '1',
        name: 'Diluc',
        title: 'The Darknight Hero',
        vision: 'Pyro',
        weapon: 'Claymore',
        gender: 'Male',
        nation: 'Mondstadt',
        affiliation: 'Dawn Winery',
        rarity: 5,
        release: '2020-09-28',
        constellation: 'Noctua',
        birthday: '2020-04-30',
        description: 'Diluc is a Pyro DPS character.',
        card: 'path/to/card.png',
        iconBig: 'path/to/icon_big.png',
        artifacts: [
          Artifact(
            id: '1',
            name: 'Crimson Witch of Flames',
            maxRarity: 5,
            twoPieceBonus: 'Pyro DMG Bonus +15%',
            fourPieceBonus: 'Increases Overload and Burning DMG by 40%',
            imagePath: 'path/to/artifact.png',
          ),
        ],
      );

      expect(model, isNotNull);
      expect(model.name, equals('Diluc'));
      expect(model.rarity, equals(5));
      expect(model.artifacts.length, equals(1));
      expect(model.artifacts.first.name, equals('Crimson Witch of Flames'));
    });

    test('JSON serialization test', () {
      final model = Character(
        id: '1',
        name: 'Diluc',
        title: 'The Darknight Hero',
        vision: 'Pyro',
        weapon: 'Claymore',
        gender: 'Male',
        nation: 'Mondstadt',
        affiliation: 'Dawn Winery',
        rarity: 5,
        release: '2020-09-28',
        constellation: 'Noctua',
        birthday: '2020-04-30',
        description: 'Diluc is a Pyro DPS character.',
        card: 'path/to/card.png',
        iconBig: 'path/to/icon_big.png',
        artifacts: [
          Artifact(
            id: '1',
            name: 'Crimson Witch of Flames',
            maxRarity: 5,
            twoPieceBonus: 'Pyro DMG Bonus +15%',
            fourPieceBonus: 'Increases Overload and Burning DMG by 40%',
            imagePath: 'path/to/artifact.png',
          ),
        ],
      );

      final json = model.toJson();
      final newModel = Character.fromJson(json);

      // Verify that the serialized and deserialized models match
      expect(newModel, isA<Character>());
      expect(newModel.name, equals(model.name));
      expect(newModel.artifacts.length, equals(model.artifacts.length));
      expect(newModel.artifacts.first.name, equals(model.artifacts.first.name));
    });
  });
}
