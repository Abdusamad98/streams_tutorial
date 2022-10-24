import 'dart:async';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController<int> streamController = StreamController<int>();

  initializeMyStream() async {
    int counter = 0;
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      counter++;
      streamController.sink.add(counter);
      // yield counter;
    }
  }


  Stream<int> myNumbers(int to) async* {
    for (int i = 1; i <= to; i++) {
      yield i;
    }
  }

  @override
  void initState() {
    initializeMyStream();
    streamController.sink.add(10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Streams in Flutter"),
      ),
      body: StreamBuilder(
        stream: streamController.stream,
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text("My Number:${snapshot.data!}"),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
