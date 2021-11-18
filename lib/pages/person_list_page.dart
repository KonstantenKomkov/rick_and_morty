import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/dataloader.dart';
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
  Object? error;

  Future<void> loadData() async {
    try {
      final personsLoad = await getData('api/character');
      setState(() {
        persons = personsLoad;
      });
    } catch (exception) {
      setState(() {
        error = exception;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    final List<Person>? currentPersons = persons;
    final Object? exception = error;
    if (currentPersons != null) {
      content = personsList(context, currentPersons);
    } else if (exception != null) {
      content = exceptionStub(context, exception);
    } else {
      content = loader(context);
    }
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(content),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        widget.title ?? "",
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 28,
        ),
      ),
    );
  }

  Widget _buildBody(Widget content) {
    return Container(
      color: Colors.purple[800],
      child: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Center(
          child: content,
        ),
      ),
    );
  }

  Widget personsList(BuildContext context, List<Person> persons) {
    return SafeArea(
      child: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) =>
            _buildViewList(context, person: persons[index]),
      ),
    );
  }

  Widget _buildViewList(
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
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
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

  Widget loader(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Loading...',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }

  Widget exceptionStub(BuildContext context, Object exception) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Ooops! Error is ${exception.toString()}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}
