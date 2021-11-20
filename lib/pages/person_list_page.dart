import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/api_person.dart';
import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/pages/view/person_list_item.dart';

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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    loadPersonsList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("Loading");
      }
    });
    super.initState();
  }

  Future<void> loadPersonsList() async {
    setState(() {
      isLoading = true;
    });
    ApiResponse response = await loadData();
    setState(() {
      isLoading = false;
    });
    if (response.isError ?? false) {
      persons = [];
      print('Show error message');
    } else {
      if (response.results == null) {
        persons = [];
      } else {
        try {
          persons = response.results!
              .map((person) => Person.fromJson(person as Map<String, dynamic>))
              .toList();
        } catch (e) {
          persons = [];
          print('Show error message');
        }
      }
    }
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
          fontSize: 28.0,
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: persons != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: ListView.builder(
                      itemCount: persons!.length + 1,
                      itemBuilder: (context, index) {
                        if (index == persons!.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return PersonListItem(
                            person: persons![index],
                          );
                        }
                      },
                      controller: _scrollController,
                    ),
                  )
                : Container(),
          );
  }
}
