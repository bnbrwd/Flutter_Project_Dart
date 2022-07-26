import 'package:dictionary_app_test/cubit/dictionary_cubit.dart';
import 'package:dictionary_app_test/repo/word_repo.dart';
import 'package:dictionary_app_test/screens/home/home_screen.dart';
import 'package:dictionary_app_test/screens/list/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetForTesting({Widget? child}) {
    return MaterialApp(
      home: child,
    );
  }

  group('Dictionary app integration testing', () {
    testWidgets('When app start it shuold render home page', (tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (_) => DictionaryCubit(WordRepository()),
        child: createWidgetForTesting(child: HomeScreen()),
      ));
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('When word  entered  then in Home page ', (tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (_) => DictionaryCubit(WordRepository()),
        child: createWidgetForTesting(child: HomeScreen()),
      ));

      const word = 'testing';
      await tester.enterText(find.byKey(const Key('searchWord')), word);

      await tester.tap(find.byKey(const Key('tapSearch')));
      await tester.pumpAndSettle();

      expect(find.byType(ListScreen), findsOneWidget);
    });
  });
}
