import 'package:example/src/form/screens/validata_form_controller.dart';
import 'package:example/src/form/screens/validata_required_text_field_validator.dart';
import 'package:example/src/form/screens/validata_text_field.dart';
import 'package:example/src/form/screens/validata_text_field_controller.dart';
import 'package:example/src/form/screens/validata_trigger_type.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late final ValidataFormController formController;
  late final ValidataTextFieldController fieldController1;
  late final ValidataTextFieldController fieldController2;

  @override
  void initState() {
    fieldController1 = ValidataTextFieldController(
      validators: [
        ValidataRequiredTextFieldValidator(
          triggers: const {ValidataTriggerType.onUnfocus},
        ),
      ],
    );
    fieldController2 = ValidataTextFieldController(
      validators: [
        ValidataRequiredTextFieldValidator(
          triggers: const {ValidataTriggerType.onUnfocus},
        ),
      ],
    );
    formController = ValidataFormController(
      fields: [
        fieldController1,
        fieldController2,
      ],
    );
    super.initState();
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ValidataTextField(
            controller: fieldController1,
          ),
          ValidataTextField(
            controller: fieldController2,
          ),
          FilledButton(
            onPressed: () {
              formController.submit();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
