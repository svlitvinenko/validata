import 'dart:async';

import 'package:example/src/form/screens/validata_field_value.dart';
import 'package:example/src/form/screens/validata_trigger_type.dart';

abstract class ValidataFieldValidator<T extends Object> {
  final Set<ValidataTriggerType> triggers;

  ValidataFieldValidator({
    this.triggers = const {},
  });

  FutureOr<String?> onTriggered({
    required ValidataTriggerType by,
    required ValidataFieldValue<T> value,
  }) async {
    final bool shouldValidate = triggers.isEmpty || triggers.contains(by) || by == ValidataTriggerType.onSubmit;
    if (shouldValidate) {
      return validate(value);
    }

    return null;
  }

  FutureOr<String?> validate(ValidataFieldValue<T> value);
}
