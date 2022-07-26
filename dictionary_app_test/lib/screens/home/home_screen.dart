import 'package:dictionary_app_test/bloc/dictionary_bloc.dart';
import 'package:dictionary_app_test/cubit/dictionary_cubit.dart';
import 'package:dictionary_app_test/screens/list/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  getDictionaryFormWidget(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Spacer(),
          const Text(
            "Dictionary App",
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Search any word you want quickly",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          TextField(
            key: const Key('searchWord'),
            controller: cubit.queryController,
            decoration: InputDecoration(
              hintText: "Search a word",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: const Icon(Icons.search),
              hintStyle: const TextStyle(color: Colors.white),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              key: const Key('tapSearch'),
              onPressed: () {
                cubit.getWordSearched();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrangeAccent,
                  padding: const EdgeInsets.all(16)),
              child: const Text("SEARCH"),
            ),
          ),
        ],
      ),
    );
  }

  getLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  getErrorWidget(message) {
    return Center(
        child: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return BlocListener(
      listener: (context, state) {
        if (state is WordSearchedState && state.words != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListScreen(state.words),
            ),
          );
        }
      },
      bloc: cubit,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: cubit.state is WordSearchingState
            ? getLoadingWidget()
            : cubit.state is ErrorState
                ? getErrorWidget("Some Error")
                : cubit.state is NoWordSearchedState
                    ? getDictionaryFormWidget(context)
                    : Container(),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   final _textEditController = TextEditingController();
//   getDictionaryFormWidget(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           const Spacer(),
//           const Text(
//             "Dictionary App",
//             style: TextStyle(
//               color: Colors.deepOrangeAccent,
//               fontSize: 34,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Text(
//             "Search any word you want quickly",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//             ),
//           ),
//           const SizedBox(
//             height: 32,
//           ),
//           TextField(
//             controller: _textEditController,
//             decoration: InputDecoration(
//               hintText: "Search a word",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4),
//                 borderSide: const BorderSide(color: Colors.transparent),
//               ),
//               fillColor: Colors.grey[100],
//               filled: true,
//               prefixIcon: const Icon(Icons.search),
//               hintStyle: const TextStyle(color: Colors.white),
//             ),
//           ),
//           const Spacer(),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 BlocProvider.of<DictionaryBloc>(context).add(
//                     DictionaryEventRequested(
//                         word: _textEditController.text.toString()));
//               },
//               style: ElevatedButton.styleFrom(
//                   primary: Colors.deepOrangeAccent,
//                   padding: const EdgeInsets.all(16)),
//               child: const Text("SEARCH"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   getLoadingWidget() {
//     return const Center(child: CircularProgressIndicator());
//   }

//   getErrorWidget(message) {
//     return Center(
//         child: Text(
//       message,
//       style: const TextStyle(color: Colors.white),
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.watch<DictionaryCubit>();

//     return BlocListener(
//       listener: (context, state) {
//         if (state is DictionaryLoaded && state.words != null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ListScreen(state.words),
//             ),
//           );
//         }
//       },
//       bloc: cubit,
//       child: Scaffold(
//           backgroundColor: Colors.blueGrey[900],
//           body: cubit.state is WordSearchingState
//               ? getLoadingWidget()
//               : cubit.state is ErrorState
//                   ? getErrorWidget("Some Error")
//                   : cubit.state is NoWordSearchedState
//                       ? getDictionaryFormWidget(context)
//                       : Container()),
//     );

//     // return BlocConsumer(listener: (context, state) {
//     //   if (state is DictionaryLoaded && state.words != null) {
//     //     Navigator.push(
//     //       context,
//     //       MaterialPageRoute(
//     //         builder: (context) => ListScreen(state.words),
//     //       ),
//     //     );
//     //   }
//     // }, builder: (context, state) {
//     //   return Scaffold(
//     //       backgroundColor: Colors.blueGrey[900],
//     //       body: state is DictionaryLoading
//     //           ? getLoadingWidget()
//     //           : state is ErrorState
//     //               ? getErrorWidget("Some Error")
//     //               : state is DictionaryLoaded
//     //                   ? getDictionaryFormWidget(context)
//     //                   : Container());
//     // });
//   }
// }
