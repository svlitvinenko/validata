import 'package:example/src/form/screens/validata_text_field_controller.dart';
import 'package:flutter/material.dart';

class ValidataTextField extends StatefulWidget {
  const ValidataTextField({super.key, required this.controller});

  final ValidataTextFieldController controller;

  @override
  State<ValidataTextField> createState() => _ValidataTextFieldState();
}

class _ValidataTextFieldState extends State<ValidataTextField> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: widget.controller.errorController,
      builder: (context, error, _) {
        return TextField(
          controller: widget.controller.textController,
          focusNode: widget.controller.focusNode,
          decoration: InputDecoration(errorText: error),
        );
      },
    );
  }
}
