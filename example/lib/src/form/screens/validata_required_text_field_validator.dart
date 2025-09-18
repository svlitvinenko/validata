import 'dart:async';

import 'package:example/src/form/screens/validata_field_validator.dart';
import 'package:example/src/form/screens/validata_field_value.dart';

final class ValidataRequiredTextFieldValidator extends ValidataFieldValidator<String> {
  ValidataRequiredTextFieldValidator({
    super.triggers = const {},
  });

  @override
  FutureOr<String?> validate(ValidataFieldValue<String> value) {
    if (value.value.trim().isEmpty) {
      return 'This field is required';
    }

    return null;
  }
}
