import 'package:dictionary_app_test/model/word_response.dart';
import 'package:dictionary_app_test/screens/list/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetForTesting({Widget? child}) {
    return MaterialApp(
      home: child,
    );
  }

  group('ScrollListTesting', () {
    late List<WordResponse> wordRes = <WordResponse>[];

    wordRes.add(WordResponse(word: 'cat', meanings: [], phonetics: []));
    wordRes.add(WordResponse(word: 'cat', meanings: [], phonetics: []));
    wordRes.add(WordResponse(word: 'cat', meanings: [], phonetics: []));
    wordRes.add(WordResponse(word: 'cat', meanings: [], phonetics: []));
    wordRes.add(WordResponse(word: 'cat', meanings: [], phonetics: []));
    wordRes.add(WordResponse(word: 'cat', meanings: [], phonetics: []));
    wordRes.add(WordResponse(word: 'cat', meanings: [], phonetics: []));
    wordRes.add(WordResponse(word: 'cat', meanings: [], phonetics: []));
    wordRes.add(WordResponse(word: 'cat', meanings: [], phonetics: []));

    testWidgets('should not scrol with less items', (tester) async {
      await tester
          .pumpWidget(createWidgetForTesting(child: ListScreen(wordRes)));

      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pump();

      final firstWordFinder = find.text('1. cat');
      expect(firstWordFinder, findsOneWidget);
    });

    testWidgets('should scroll with a lot of items', (tester) async {
      await tester
          .pumpWidget(createWidgetForTesting(child: ListScreen(wordRes)));

      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pump();

      final firstWordFinder = find.text('0. cat');
      final nineCatFinder = find.text('9. cat');
      final listTilesFinder = find.byType(ListTile);
      expect(firstWordFinder, findsNothing);
      expect(nineCatFinder, findsOneWidget);
      expect(listTilesFinder, findsNWidgets(9));
    });

    testWidgets('should show only 2 on small screen size', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(320, 350);
      await tester
          .pumpWidget(createWidgetForTesting(child: ListScreen(wordRes)));
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('should throw error if empty list is provided', (tester) async {
      await tester
          .pumpWidget(createWidgetForTesting(child: const ListScreen([])));

      expect(tester.takeException(), isAssertionError);
    });
  });
}
