import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/api_person.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/pages/person_details_page.dart';

class PersonListPage extends StatefulWidget {
  final String? title;
  static const String routeName = '/';

  const PersonListPage({
    Key? key,
    this.title = "Characters",
  }) : super(
          key: key,
        );

  @override
  _PersonListPageState createState() => _PersonListPageState();
}

class _PersonListPageState extends State<PersonListPage> {
  List<Person>? persons;
  bool isLoading = false;

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    persons = await loadPersons();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(
        context,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
  ) {
    return AppBar(
      title: Text(
        widget.title ?? "",
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 28.0,
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    return Container(
      color: Colors.purple[800],
      child: Padding(
        padding: const EdgeInsets.only(
          top: 7.0,
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Center(
                child: persons != null
                    ? _buildPersonsList(
                        context,
                        persons: persons!,
                      )
                    : Container(),
              ),
      ),
    );
  }

  Widget _buildPersonsList(
    BuildContext context, {
    required List<Person> persons,
  }) {
    return SafeArea(
      child: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) => _buildListItem(
          context,
          person: persons[index],
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required Person person,
  }) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonDetailsPage(
              id: person.id,
            ),
          ),
        ),
      },
      child: _buildRow(context, person),
    );
  }

  Widget _buildRow(BuildContext context, Person person) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 5.0,
      ),
      color: person.status == 'Dead' ? Colors.black54 : Colors.white24,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(person.image),
            ),
          ),
          Flexible(
            child: Text(
              person.name,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 1,
              style: TextStyle(
                fontSize: 25,
                color: person.status == 'Dead' ? Colors.white70 : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
