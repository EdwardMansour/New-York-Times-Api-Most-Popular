import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ny_times/core/dependency-injection.dart';
import 'package:ny_times/main.dart';

void main() async {
  init();
  testWidgets('Home page testing widgets', (WidgetTester tester) async {
    //! find all widget needed
    final searchTextField = find.byKey(ValueKey('search textField'));
    final searchButton = find.byKey(ValueKey('search button or close'));
    final menuButton = find.byKey(ValueKey('menu button'));

    //!execute the test
    await tester.pumpWidget(MyApp());
    await tester.tap(searchButton);
    await tester.pump();
    await tester.enterText(searchTextField, 'edward');
    await tester.tap(menuButton);
    //! check outputs
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(CircularProgressIndicator), findsWidgets);
    expect(find.text('edward'), findsOneWidget);
  });
}

/// Note that When I want to find a widget that depends on an HTTP client request
/// always this call return 400 and that I can't test it, waiting for the flutter SDK update
/// to improve this
