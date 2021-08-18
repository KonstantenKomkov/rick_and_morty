import 'package:flutter/material.dart';
import 'package:rick_and_morty/locationloader.dart';

class LocationDetailsPage extends StatefulWidget {
  const LocationDetailsPage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  _LocationDetailsPageState createState() => _LocationDetailsPageState();
}

class _LocationDetailsPageState extends State<LocationDetailsPage> {
  LocationDetails? location;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final locationInfo = await loadLocation(widget.url);
    setState(() {
      location = locationInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    final location = this.location;
    if (location == null) {
      widget = const Center(
        child: Text(
          "Please, wait...",
        ),
      );
    } else {
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
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Type: ${location.dimension}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: _buildAppBar(location != null ? location.name : ''),
      body: widget,
    );
  }

  PreferredSizeWidget _buildAppBar(String name) {
    return AppBar(
      title: Text(
        "R&M: $name",
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 28,
        ),
      ),
    );
  }
}
