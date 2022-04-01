import 'package:dictionary_app_test/cubit/dictionary_cubit.dart';
import 'package:dictionary_app_test/repo/word_repo.dart';
import 'package:dictionary_app_test/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetForTesting({Widget? child}) {
    return MaterialApp(
      home: child,
    );
  }

  group('HomePage Testing \n', () {
    testWidgets('When render Home Page', (tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (_) => DictionaryCubit(WordRepository()),
        child: createWidgetForTesting(child: HomeScreen()),
      ));
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('When word enters into search field', (tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (_) => DictionaryCubit(WordRepository()),
        child: createWidgetForTesting(child: HomeScreen()),
      ));

      var textField = find.byType((TextField));
      expect(textField, findsOneWidget);
      final textFieldWidget = find.byKey(const Key('searchWord'));
      await tester.enterText(textFieldWidget, 'cat');
      expect(find.text('cat'), findsOneWidget);
    });

    testWidgets('When tap on search button', (tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (_) => DictionaryCubit(WordRepository()),
        child: createWidgetForTesting(child: HomeScreen()),
      ));
      const word = 'lunch';
      await tester.enterText(find.byKey(const Key('searchWord')), word);

      await tester.tap(find.byKey(const Key('tapSearch')));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
    });
  });
}
