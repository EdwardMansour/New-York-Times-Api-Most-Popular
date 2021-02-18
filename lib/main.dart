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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeProvider>(
            create: (context) => sl<HomeProvider>(),
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
