import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dictionary_app_test/main.dart' as app;

void main() {
  group('Dictionary App\n', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Dictionary App Testing', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final searchField = find.byKey(const Key('searchWord'));
      final searchButton = find.byKey(const Key('tapSearch'));

      //Enter word that have to search
      await tester.enterText(searchField, 'cat');
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));

      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));

      //find first item of list
      final firstWord = find.byType(ListTile).first;
      await tester.tap(firstWord);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
    });
  });
}
