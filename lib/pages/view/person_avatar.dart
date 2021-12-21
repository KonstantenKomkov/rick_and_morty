import 'package:flutter/material.dart';

class PersonAvatar extends StatelessWidget {
  final String? placeholder;
  final String image;
  final double radius;
  const PersonAvatar({
    Key? key,
    this.placeholder,
    required this.image,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: ClipOval(
        child: placeholder != null
            ? FadeInImage.assetNetwork(
                placeholder: placeholder!,
                image: image,
              )
            : Image.network(
                image,
              ),
      ),
    );
  }
}
