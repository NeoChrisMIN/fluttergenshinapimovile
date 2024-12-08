import 'package:flutter_test/flutter_test.dart';
import 'package:fluttergenshinapimovile/models/artifact_model.dart';

void main() {
  group('Artifact Tests', () {
    test('Model creation test', () {
      final model = Artifact(
        id: '1',
        name: 'Noblesse Oblige',
        maxRarity: 5,
        twoPieceBonus: 'ATK +20%',
        fourPieceBonus: 'Increases Burst DMG by 25%',
        imagePath: 'path/to/image.png',
      );
      expect(model, isNotNull);
      expect(model.id, equals('1'));
      expect(model.name, equals('Noblesse Oblige'));
      expect(model.maxRarity, equals(5));
      expect(model.twoPieceBonus, equals('ATK +20%'));
      expect(model.fourPieceBonus, equals('Increases Burst DMG by 25%'));
      expect(model.imagePath, equals('path/to/image.png'));
    });

    test('JSON serialization test', () {
      final model = Artifact(
        id: '1',
        name: 'Noblesse Oblige',
        maxRarity: 5,
        twoPieceBonus: 'ATK +20%',
        fourPieceBonus: 'Increases Burst DMG by 25%',
        imagePath: 'path/to/image.png',
      );
      final json = model.toJson();
      final newModel = Artifact.fromJson(json);

      // Verify that the serialized and deserialized models match
      expect(newModel, isA<Artifact>());
      expect(newModel.id, equals(model.id));
      expect(newModel.name, equals(model.name));
      expect(newModel.maxRarity, equals(model.maxRarity));
      expect(newModel.twoPieceBonus, equals(model.twoPieceBonus));
      expect(newModel.fourPieceBonus, equals(model.fourPieceBonus));
      expect(newModel.imagePath, equals(model.imagePath));
    });
  });
}
