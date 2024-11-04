// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:fluttergenshinapimovile/main.dart';

void main() {
  testWidgets('Character list displays characters correctly', (WidgetTester tester) async {
    // Construir la aplicación y mostrar el widget en la prueba
    await tester.pumpWidget(GenshinWikiApp());

    // Verificar si los personajes de prueba aparecen en la lista
    expect(find.text('Traveler'), findsOneWidget);
    expect(find.text('Keqing'), findsOneWidget);
    expect(find.text('Kaedehara Kazuha'), findsOneWidget);
    expect(find.text('Kamisato Ayato'), findsOneWidget);
    expect(find.text('Xiangling'), findsOneWidget);
    expect(find.text('Xingqiu'), findsOneWidget);
  });
}