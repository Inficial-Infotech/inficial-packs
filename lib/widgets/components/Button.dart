import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PXButton extends StatelessWidget {
  final Color colour;
  final String title;
  final Function onPressed;

  const PXButton({
    required this.title,
    required this.colour,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CupertinoButton.filled(
        onPressed: onPressed(),
        child: const Text('Continue'),
      ),
    );
  }
}
