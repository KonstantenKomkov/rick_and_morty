import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/pages/not_found_page.dart';
import 'package:rick_and_morty/pages/person_details_page.dart';
import 'package:rick_and_morty/pages/person_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const PersonListPage(),
      initialRoute: '/',
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return const NotFoundPage();
          },
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case PersonListPage.routeName:
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return const PersonListPage();
              },
            );
          default:
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return const NotFoundPage();
              },
            );
        }
      },
    );
  }
}
