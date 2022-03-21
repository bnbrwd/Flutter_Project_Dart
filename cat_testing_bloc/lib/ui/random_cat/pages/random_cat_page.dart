import 'package:cat_testing_bloc/repository/service.dart';
import 'package:cat_testing_bloc/ui/random_cat/random_cat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomCatPage extends StatelessWidget {
  const RandomCatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CatRepository(service: CatService()),
      child: BlocProvider(
        create: (context) =>
            RandomCatBloc(catRepository: context.read<CatRepository>())
              ..add(SearchRandomCat()),
        child: const RandomCatLayout(),
      ),
    );
  }
}
