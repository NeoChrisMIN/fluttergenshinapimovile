import 'package:flutter_test/flutter_test.dart';
import 'package:fluttergenshinapimovile/models/weapon_model.dart';

void main() {
  group('Weapon Tests', () {
    test('Model creation test', () {
      final model = Weapon(
        id: '1',
        name: 'Test Weapon',
        type: 'Sword',
        rarity: 5,
        baseAttack: 100,
        subStat: 'ATK%',
        passiveName: 'Test Passive',
        passiveDesc: 'This is a test passive description',
        location: 'Gacha',
        ascensionMaterial: 'Test Material',
        image: 'test_image.png',
      );
      expect(model, isNotNull);
    });

    test('JSON serialization test', () {
      final model = Weapon(
        id: '1',
        name: 'Test Weapon',
        type: 'Sword',
        rarity: 5,
        baseAttack: 100,
        subStat: 'ATK%',
        passiveName: 'Test Passive',
        passiveDesc: 'This is a test passive description',
        location: 'Gacha',
        ascensionMaterial: 'Test Material',
        image: 'test_image.png',
      );
      final json = model.toJson();
      final newModel = Weapon.fromJson(json);
      expect(newModel, isA<Weapon>());
      expect(newModel.id, equals(model.id));
      expect(newModel.name, equals(model.name));
    });
  });
}
