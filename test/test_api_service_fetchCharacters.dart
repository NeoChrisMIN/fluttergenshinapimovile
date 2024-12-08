import 'package:flutter_test/flutter_test.dart';
import 'package:fluttergenshinapimovile/services/api_service.dart';
import 'package:fluttergenshinapimovile/models/character_model.dart';

void main() {
  group('API Service Character Tests', () {
    test('Fetch Character test', () async {
      final apiService = ApiService();
      final result = await apiService.fetchCharacters();
      expect(result, isNotNull);
      expect(result, isA<List<Character>>());
    });
  });
}
