import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/pages/person_details_page.dart';

class PersonListItem extends StatelessWidget {
  final Person person;
  const PersonListItem({
    Key? key,
    required this.person,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PersonDetailsPage(
              id: person.id,
            ),
          ),
        ),
      },
      child: _buildPersonItem(context), //_buildRow(context, person),
    );
  }

  Widget _buildPersonItem(
    BuildContext context,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            color: Colors.grey,
            offset: Offset(
              2.0,
              2.0,
            ),
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 48.0,
              backgroundImage: NetworkImage(person.image),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
              ),
              child: Text(
                person.name,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 21.0,
                ),
              ),
            ),
          ),
        ],
      ),
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
