import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/api_person.dart';
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
  bool listViewBuilt = false;
  Info? info;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    myFunc();
    _scrollController.addListener(() {
      // TODO: если ответ до этого не был пуст и без ошибок
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadNextPage = true;
        myFunc();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> myFunc() async {
    setState(() {
      isLoading = true;
    });
    final ApiResponse response = await loadPersonsList(
      loadNextPage: loadNextPage,
      info: info,
    );
    setState(() {
      isLoading = false;
      listViewBuilt = true;
    });
    if (response.isError) {
      BotToast.showText(text: response.error!);
    } else {
      info = response.info;
      if (response.results != null) {
        try {
          persons.addAll(response.results as List<Person>);
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
          ? listViewBuilt
              ? ListView.builder(
                  itemCount: persons.length + (isLoading ? 1 : 0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index < persons.length) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: PersonListItem(
                            person: persons[index],
                          ),
                        );
                      } else {
                        return PersonListItem(
                          person: persons[index],
                        );
                      }
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
                )
          : const Text(
              'No characters',
            ),
    );
  }
}
