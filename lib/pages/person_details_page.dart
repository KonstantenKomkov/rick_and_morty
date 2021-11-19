import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/pages/location_details_page.dart';

class PersonDetailsPage extends StatefulWidget {
  static const String routeName = '/person_details';
  final int id;
  final String? title;
  const PersonDetailsPage({
    Key? key,
    required this.id,
    this.title,
  }) : super(
          key: key,
        );

  @override
  _PersonDetailsPageState createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  Person? person;

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  Future<void> loadData() async {
    person = await loadPerson(
      id: widget.id,
    );
  }

  Future<Person> loadPerson({
    required int id,
  }) async {
    final http.Response response = await http
        .get(Uri.parse("https://rickandmortyapi.com/api/character/$id"));
    final Map<String, dynamic> jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return Person.fromJson(jsonResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(
        person?.name ?? "",
      ),
      body: _buildBody(context, person),
    );
  }

  Widget _buildBody(
    BuildContext context,
    Person? person,
  ) {
    return person == null
        ? const Center(
            child: Text(
              "Please, wait...",
            ),
          )
        : Container(
            color: person.status == 'Dead'
                ? Colors.purple[800]
                : Colors.purple[200],
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                    ),
                    child: Image.network(
                      person.image,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Characteristics',
                        style: TextStyle(
                          fontSize: 26.0,
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
                              fontSize: 16.0,
                              color: person.status == 'Dead'
                                  ? Colors.white70
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            'Species: ${person.species}',
                            style: TextStyle(
                              fontSize: 16.0,
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
                              fontSize: 16.0,
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
                              fontSize: 16.0,
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
                            url: person.location.url,
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
                            fontSize: 16.0,
                            color: person.status == 'Dead'
                                ? Colors.white70
                                : Colors.black,
                          ),
                        ),
                        Text(
                          person.location.name,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 16.0,
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

  PreferredSizeWidget _buildAppBar(String name) {
    return AppBar(
      title: Text(
        widget.title ?? "",
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 28.0,
        ),
      ),
    );
  }
}
