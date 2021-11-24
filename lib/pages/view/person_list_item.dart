import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/person.dart';

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
      onTap: () => Navigator.of(context).pushNamed(
        '/person_details',
        arguments: {
          "id": person.id,
        },
      ),
      child: _buildPersonItem(context),
    );
  }

  Color getStatusColor({
    required String status,
  }) {
    switch (status) {
      case "Alive":
        return Colors.green;
      case "Dead":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildPersonItem(
    BuildContext context,
  ) {
    return Container(
      height: 116.0,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardImage(context),
          _buildCardInfo(context),
        ],
      ),
    );
  }

  Widget _buildCardImage(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 50.0,
        backgroundImage: NetworkImage(person.image),
      ),
    );
  }

  Widget _buildCardInfo(
    BuildContext context,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPersonName(context),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 4.0,
              ),
              child: _buildStatusRow(context),
            ),
            ..._buildPersonLocation(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonName(
    BuildContext context,
  ) {
    return Text(
      person.name,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 21.0,
      ),
    );
  }

  Widget _buildStatusRow(
    BuildContext context,
  ) {
    return Row(
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: getStatusColor(
              status: person.status,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        Text(
          "${person.species} - ${person.status}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  List<Widget> _buildPersonLocation(
    BuildContext context,
  ) {
    return [
      const Padding(
        padding: EdgeInsets.only(
          bottom: 4.0,
        ),
        child: Text("Origin:"),
      ),
      Text(
        person.origin.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
    ];
  }
}
