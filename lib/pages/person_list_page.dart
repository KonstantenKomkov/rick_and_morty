import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/api_person.dart';
import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/info.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/pages/view/person_list_item.dart';
import 'package:rick_and_morty/response_methods.dart';

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
  // bool isLoading = false;
  // bool loadNextPage = false;
  // bool listViewBuilt = false;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> loadNextPage = ValueNotifier(false);
  ValueNotifier<bool> listViewBuilt = ValueNotifier(false);
  Info? info;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    loadPersonsList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //loadNextPage = true;

        loadNextPage.value = true;
        loadPersonsList(
          loadNextPage: true,
          info: info,
        );
        loadNextPage.value = false;
        //loadNextPage = false;
      }
    });
    print("ListViewBuilt: = ${listViewBuilt.value}");
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadListData() async {
    // setState(() {
    //   isLoading = true;
    // });
    isLoading.value = true;
    final ApiResponse response = await getListData(
      undecodedPath: 'api/character',
      loadNextPage: loadNextPage.value, //loadNextPage,
      info: info,
    );
    // setState(() {
    //   isLoading = false;
    //   listViewBuilt = true;
    // });
    isLoading.value = false;
    listViewBuilt.value = true;
    print("ListViewBuilt: = ${listViewBuilt.value}");
    if (response.isError) {
      // print('Error: ${response.error}');
      BotToast.showText(text: "Error of loading data");
    } else {
      info = response.info;
      if (response.results != null) {
        try {
          final List<dynamic> decodedData = response.results! as List<dynamic>;
          final List<Person> _persons = decodedData
              .map(
                (person) => Person.fromJson(person as Map<String, dynamic>),
              )
              .toList();
          persons.addAll(_persons);
        } catch (e) {
          // print('Error: $e');
          BotToast.showText(text: "Error of parsing data");
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
    return Center(
      child: persons.isNotEmpty
          ? ValueListenableBuilder(
              valueListenable: listViewBuilt,
              builder: (BuildContext context, bool value, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: listViewBuilt.value
                      ? ListView.builder(
                          // itemCount: persons.length + (isLoading ? 1 : 0),
                          itemCount: persons.length + (isLoading.value ? 1 : 0),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index < persons.length) {
                              return PersonListItem(
                                person: persons[index],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                          controller: _scrollController,
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                );
              },
            )
          : const Text(
              'No characters',
            ),
    );
  }
}
