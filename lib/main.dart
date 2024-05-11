import 'package:flutter/cupertino.dart';

import 'Presentation/TabBar/TabBarView.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const TabBarView(),
    );
  }
}

