import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/dataloader.dart';
import 'package:flutter_first_app/personwidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(
        title: 'Rick and Morty',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person>? persons;
  Object? error;

  Future<void> loadData() async {
    try {
      final personsLoad = await loadPersons();
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
      title: const Text(
        "R&M: Characters",
        style: TextStyle(
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
            _buildViewList(context, persons[index]),
      ),
    );
  }

  Widget _buildViewList(BuildContext context, Person person) {
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
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundImage: NetworkImage(person.avatar),
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
