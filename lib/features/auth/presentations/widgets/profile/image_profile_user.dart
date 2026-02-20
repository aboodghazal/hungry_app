import 'package:flutter/material.dart';

class ImageProfileUser extends StatelessWidget {
  final Widget imageWidget;
  const ImageProfileUser({super.key, required this.imageWidget});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: Colors.black26),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ClipOval(
          child: SizedBox(
            width: 110,
            height: 110,
            child: imageWidget,
          ),
        ),
      ),
    );
  }
}
