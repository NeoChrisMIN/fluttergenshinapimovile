import 'package:flutter_test/flutter_test.dart';
import 'package:fluttergenshinapimovile/services/api_service.dart';
import 'package:fluttergenshinapimovile/models/weapon_model.dart';

void main() {
  group('API Service Weapon Tests', () {
    test('Fetch Weapon test', () async {
      final apiService = ApiService();
      final result = await apiService.fetchWeapons();
      expect(result, isNotNull);
      expect(result, isA<List<Weapon>>());
    });
  });
}
