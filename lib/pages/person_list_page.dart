import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/api_person.dart';
import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/info.dart';
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
  List<Person> persons = [];
  bool isLoading = false;
  bool loadNextPage = false;
  Info? info;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    loadPersonsList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadNextPage = true;
        loadPersonsList();
        loadNextPage = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadPersonsList() async {
    setState(() {
      isLoading = true;
    });
    final ApiResponse response = await loadListData(
      loadNextPage: loadNextPage,
      info: info,
    );
    setState(() {
      isLoading = false;
    });
    if (response.isError ?? false) {
      persons += [];
      print('Show error message');
    } else {
      info = response.info;
      if (response.results == null) {
        persons += [];
      } else {
        try {
          //response.results.cast<List<Map<String, dynamic>>>();
          persons += response.results!
              .cast<List<Map<String, dynamic>>>()
              .map<List<Map<String, dynamic>>>(
                  (person) => Person.fromJson(person as Map<String, dynamic>))
              .toList();
        } catch (e) {
          persons += [];
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
      resizeToAvoidBottomInset: false,
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
            child: persons.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: ListView.builder(
                      itemCount: persons.length + 1,
                      itemBuilder: (context, index) {
                        if (index == persons.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return PersonListItem(
                            person: persons[index],
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
