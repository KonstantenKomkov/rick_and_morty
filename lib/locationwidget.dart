import 'package:flutter/material.dart';
import 'package:flutter_first_app/locationloader.dart';

class LocationDetailsPage extends StatefulWidget {
  LocationDetailsPage({required this.url}) : super();

  final String url;

  @override
  _State createState() => _State(url: url);
}

class _State extends State<LocationDetailsPage> {
  _State({required this.url}) : super();

  String url;
  // null-safety, don't use = null
  LocationDetails? location;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var locationInfo = await loadLocation(url);
    setState(() {
      location = locationInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    final location = this.location;
    if (location == null)
      widget = Center(
        child: Text(
          "Please, wait...",
        ),
      );
    else
      widget = Container(
        color: Colors.purple[400],
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Type: ${location.type}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Type: ${location.dimension}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

    return Scaffold(
      appBar: _buildAppBar(location != null ? location.name : ''),
      body: widget,
    );
  }

  PreferredSizeWidget _buildAppBar(String name) {
    return AppBar(
      title: Text(
        "R&M: $name",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 28,
        ),
      ),
    );
  }
}
