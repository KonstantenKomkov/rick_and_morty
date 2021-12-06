import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models/location.dart';

class LocationDetailsPage extends StatefulWidget {
  static const String routeName = '/location_details';
  final String title;
  final String url;
  const LocationDetailsPage({
    Key? key,
    required this.title,
    required this.url,
  }) : super(
          key: key,
        );

  @override
  _LocationDetailsPageState createState() => _LocationDetailsPageState();
}

class _LocationDetailsPageState extends State<LocationDetailsPage> {
  Location? location;

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  Future<void> loadData() async {
    location = await loadLocation(
      url: widget.url,
    );
  }

  Future<Location> loadLocation({
    required String url,
  }) async {
    final http.Response response = await http.get(Uri.parse(url));
    final Map<String, dynamic> jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return Location.fromJson(jsonResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(
        context,
        title: widget.title,
      ),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context, {
    required String title,
  }) {
    return AppBar(
      title: Text(
        title,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return location == null
        ? const Center(
            child: Text(
              "Please, wait...",
            ),
          )
        : Container(
            color: Colors.purple[400],
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Type: ${location!.type}",
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Type: ${location!.dimension}",
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
