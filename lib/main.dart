import 'package:flutter/material.dart';
import 'package:ny_times/core/gloable_variables.dart';
import 'package:ny_times/view/home.dart';
import 'package:provider/provider.dart';

import 'controller/home_page_provider.dart';
import 'core/dependency-injection.dart';

void main() {
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NY Times Most Popular',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider(),
          ),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) {
            height = constraints.maxHeight;
            width = constraints.maxWidth;
            return Home();
          },
        ),
      ),
    );
  }
}
