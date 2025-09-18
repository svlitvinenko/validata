import 'package:example/src/form/screens/validata_text_field_controller.dart';
import 'package:example/src/form/screens/validata_trigger_type.dart';

class ValidataFormController {
  final List<ValidataTextFieldController> fields;

  ValidataFormController({required this.fields});

  Future<void> submit() async {
    await validate();
  }

  Future<bool> validate() async {
    final List<bool> results = await Future.wait(
      fields.map((f) async => await f.validate(trigger: ValidataTriggerType.onSubmit)),
    );
    final bool result = results.every((result) => result == true);
    return result;
  }

  void dispose() {
    for (final field in fields) {
      field.dispose();
    }
  }
}
