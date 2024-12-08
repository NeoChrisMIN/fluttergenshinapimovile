import 'package:flutter_test/flutter_test.dart';
import 'package:fluttergenshinapimovile/services/api_service.dart';
import 'package:fluttergenshinapimovile/models/artifact_model.dart';

void main() {
  group('API Service Artifact Tests', () {
    test('Fetch Artifact test', () async {
      final apiService = ApiService();
      final result = await apiService.fetchArtifacts();
      expect(result, isNotNull);
      expect(result, isA<List<Artifact>>());
    });
  });
}
