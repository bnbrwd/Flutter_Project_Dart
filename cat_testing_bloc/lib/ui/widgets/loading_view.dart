import 'package:flutter/material.dart';

import '../../utils/const_keys_app.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key(ConstWidgetKeysApp.catLoading),
      child: CircularProgressIndicator(color: Colors.green),
    );
  }
}
