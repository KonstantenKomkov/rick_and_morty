import 'package:flutter/material.dart';
import 'package:flutter_first_app/personloader.dart';
import 'package:flutter_first_app/locationwidget.dart';

class PersonDetailsPage extends StatefulWidget {
  const PersonDetailsPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _PersonDetailsPageState createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  PersonDetails? person;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final personInfo = await loadPerson(widget.id);
    setState(() {
      person = personInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    final person = this.person;
    if (person == null) {
      widget = const Center(
        child: Text(
          "Please, wait...",
        ),
      );
    } else {
      widget = Container(
        color:
            person.status == 'Dead' ? Colors.purple[800] : Colors.purple[200],
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.network(
                  person.avatar,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Characteristics',
                    style: TextStyle(
                      fontSize: 26,
                      color: person.status == 'Dead'
                          ? Colors.white70
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Status: ${person.status == 'Dead' ? person.status : "still ${person.status}"}',
                        style: TextStyle(
                          fontSize: 16,
                          color: person.status == 'Dead'
                              ? Colors.white70
                              : Colors.black,
                        ),
                      ),
                      Text(
                        'Species: ${person.species}',
                        style: TextStyle(
                          fontSize: 16,
                          color: person.status == 'Dead'
                              ? Colors.white70
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Created: ${person.created}',
                        style: TextStyle(
                          fontSize: 16,
                          color: person.status == 'Dead'
                              ? Colors.white70
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Sex: ${person.gender}',
                        style: TextStyle(
                          fontSize: 16,
                          color: person.status == 'Dead'
                              ? Colors.white70
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationDetailsPage(
                        url: person.locationUrl,
                      ),
                    ),
                  )
                },
                child: Column(
                  children: [
                    Text(
                      'Origin location:',
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16,
                        color: person.status == 'Dead'
                            ? Colors.white70
                            : Colors.black,
                      ),
                    ),
                    Text(
                      person.locationName,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16,
                        color: person.status == 'Dead'
                            ? Colors.white70
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: _buildAppBar(person != null ? person.name : ''),
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
