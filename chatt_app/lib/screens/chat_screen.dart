import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseOptions get firebaseOptions => const FirebaseOptions(
        appId: '',
        apiKey: '',
        projectId: '',
        messagingSenderId: '',
      );

  //Firebase initialiaze app
  Future<void> getDemo() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: firebaseOptions);
  }

  //get value from firestore.
  Future<void> getValue() async {
    final result = FirebaseFirestore.instance
        .collection('chats/Q94YaXWstlHvatIsXjKF/messages');
    print(result.snapshots().listen((data) {
      data.docs.forEach((doc) {
        print(doc['text']);
      });
      print(data);
    }));
  }

  int itemLengthData;
  //getString length
  Future<void> getStringLength() async {
    final result = FirebaseFirestore.instance
        .collection('chats/Q94YaXWstlHvatIsXjKF/messages');
    result.snapshots().listen((data) {
      
    });
  }

  // CollectionReference _collectionRef = FirebaseFirestore.instance
  //     .collection('chats/Q94YaXWstlHvatIsXjKF/messages');

  //   // Get data from docs and convert map to List
  //   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  //   print(allData);
  // }

  @override
  void initState() {
    getDemo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (ctx, index) => Container(
          padding: const EdgeInsets.all(10),
          child: const Text('This works'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          getValue();
        },
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: StreamBuilder(
  //       stream: FirebaseFirestore.instance
  //           .collection('chats/Q94YaXWstlHvatIsXjKF/messages').snapshots(),
  //       builder: (ctx, streamSnapshot) {
  //         if(streamSnapshot.connectionState == ConnectionState.waiting){
  //           return Center(child: CircularProgressIndicator(),);
  //         }
          
  //         return ListView.builder(
  //           itemCount: itemLengthData,
  //           itemBuilder: (ctx, index) => Container(
  //             padding: const EdgeInsets.all(10),
  //             child: const Text('This works'),
  //           ),
  //         );
  //       },
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       child: Icon(Icons.add),
  //       onPressed: () {
  //         getValue();
  //       },
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: ListView.builder(
  //       itemCount: 10,
  //       itemBuilder: (ctx, index) => Container(
  //         padding: const EdgeInsets.all(10),
  //         child: const Text('This works'),
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       child: Icon(Icons.add),
  //       onPressed: () {
  //         getValue();
  //       },
  //     ),
  //   );
  // }
}
