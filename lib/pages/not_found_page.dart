import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatefulWidget {
  static const String routeName = '/not_found';

  const NotFoundPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _NotFoundPageState createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Page not found',
        ),
      ),
      body: const Center(
        child: Text(
          'Page not found',
        ),
      ),
    );
  }
}
