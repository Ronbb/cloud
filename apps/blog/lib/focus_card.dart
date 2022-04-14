import 'package:flutter/material.dart';

class FocusableCard extends StatefulWidget {
  const FocusableCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<FocusableCard> createState() => _FocusableCardState();
}

class _FocusableCardState extends State<FocusableCard> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (value) {
        setState(() {
          focused = value;
        });
      },
      child: Card(
        margin: const EdgeInsets.all(16.0),
        elevation: focused ? 8 : 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.child,
        ),
      ),
    );
  }
}
