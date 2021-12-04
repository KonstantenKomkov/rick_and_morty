import 'package:flutter/material.dart';
import 'package:rick_and_morty/api_person.dart';
import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/pages/location_details_page.dart';
import 'package:rick_and_morty/pages/view/person_status.dart';

class PersonDetailsPage extends StatefulWidget {
  static const String routeName = '/person_details';
  final int id;
  final String title;
  const PersonDetailsPage({
    Key? key,
    required this.id,
    required this.title,
  }) : super(
          key: key,
        );

  @override
  _PersonDetailsPageState createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  Person? person;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadPerson(id: widget.id);
    setState(() {});
  }

  Future<void> loadPerson({
    required int id,
  }) async {
    setState(() {
      isLoading = true;
    });

    final ApiResponse response = await loadObjectData(id: id);

    if (response.isError ?? false) {
      person = null;
      print("Error: ${response.error}");
    } else {
      try {
        person = Person.fromJson(response.results as Map<String, dynamic>);
      } catch (e) {
        person = null;
        print("Error: $e");
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(
        title: widget.title,
      ),
      body: _buildBody(context, person),
    );
  }

  PreferredSizeWidget _buildAppBar({
    required String title,
  }) {
    return AppBar(
      title: Text(
        title,
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    Person? person,
  ) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : person != null
            ? _buildPersonDetailsWidget(
                context,
                person: person,
              )
            : const Center(
                child: Text(
                  "No character",
                ),
              );
  }

  Widget _buildPersonDetailsWidget(
    BuildContext context, {
    required Person person,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              _buildPersonAvatar(
                context,
                image: person.image,
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Flexible(
          //       child: _buildPersonAvatar(
          //         context,
          //         image: person.image,
          //       ),
          //     ),
          //   ],
          // ),
          Flex(
            direction: Axis.vertical,
            children: [
              _buildPersonName(
                context,
                name: person.name,
              ),
            ],
          ),
          Flex(
            direction: Axis.vertical,
            children: [
              _buildPersonStatus(
                context,
                person: person,
              ),
            ],
          ),
          // Flex(
          //   direction: Axis.vertical,
          //   children: [
          //     _buildPersonRow(
          //       context,
          //       title: "Gender: ",
          //       value: person.gender,
          //     ),
          //   ],
          // ),
          _buildPersonRow(
            context,
            title: "Gender: ",
            value: person.gender,
          ),
          _buildPersonRow(
            context,
            title: "Origin: ",
            value: person.origin.name,
          ),
          _buildPersonRow(
            context,
            title: "Location: ",
            value: person.location.name,
          ),
          // GestureDetector(
          //   onTap: () => {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => LocationDetailsPage(
          //           url: person.location.url,
          //         ),
          //       ),
          //     )
          //   },
          //   child: Column(
          //     children: [
          //       Text(
          //         'Origin location:',
          //         overflow: TextOverflow.ellipsis,
          //         softWrap: true,
          //         style: TextStyle(
          //           fontSize: 16.0,
          //           color:
          //               person.status == 'Dead' ? Colors.white70 : Colors.black,
          //         ),
          //       ),
          //       Text(
          //         person.location.name,
          //         overflow: TextOverflow.ellipsis,
          //         softWrap: true,
          //         style: TextStyle(
          //           fontSize: 16.0,
          //           color:
          //               person.status == 'Dead' ? Colors.white70 : Colors.black,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildPersonAvatar(
    BuildContext context, {
    required String image,
  }) {
    final double radius = MediaQuery.of(context).size.width / 4;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: radius * 2,
        child: ClipOval(
          child: Image.network(
            image,
          ),
        ),
      ),
    );
  }

  Widget _buildPersonName(
    BuildContext context, {
    required String name,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
      ),
      child: Text(
        name.toUpperCase(),
        style: const TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPersonStatus(
    BuildContext context, {
    required Person person,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16.0,
      ),
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        right: 16.0,
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: PersonStatus(
        status: person.status,
        species: person.species,
        fontSize: 20.0,
        textColor: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildPersonRow(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
      ),
      child: Row(
        children: [
          Text.rich(
            softWrap: true,
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
