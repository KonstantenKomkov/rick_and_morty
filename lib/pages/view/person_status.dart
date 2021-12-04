import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonStatus extends StatelessWidget {
  final String status;
  final String species;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  const PersonStatus({
    Key? key,
    required this.status,
    required this.species,
    this.fontSize,
    this.textColor,
    this.fontWeight,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: getStatusColor(
              status: status,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        Flexible(
          child: Text(
            "$species - $status",
            maxLines: 1,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
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
}
