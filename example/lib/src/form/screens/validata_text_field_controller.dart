import 'dart:async';

import 'package:example/src/form/screens/validata_field_validator.dart';
import 'package:example/src/form/screens/validata_field_value.dart';
import 'package:example/src/form/screens/validata_trigger_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

final class ValidataTextFieldController
    with ChangeNotifier
    implements ValueListenable<ValidataFieldValue<String>> {
  late final TextEditingController textController;
  late final ValueNotifier<String?> errorController;
  late final FocusNode focusNode;

  final List<ValidataFieldValidator> validators;

  @override
  ValidataFieldValue<String> get value => _value;

  ValidataFieldValue<String> _value = ValidataFieldValue<String>(value: '', error: null);

  late final List<ChangeNotifier> _listenables;

  ValidataTextFieldController({this.validators = const []}) {
    textController = TextEditingController()..addListener(_onTextChanged);
    errorController = ValueNotifier<String?>(null);
    focusNode = FocusNode()..addListener(_onFocusChanged);
    _listenables = [textController, errorController, focusNode];
    addListener(_reevaluate);
  }

  @override
  void addListener(VoidCallback listener) {
    for (final listenable in _listenables) {
      listenable.addListener(listener);
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    for (final listenable in _listenables) {
      listenable.removeListener(listener);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (final listenable in _listenables) {
      listenable.dispose();
    }
  }

  FutureOr<bool> validate({required ValidataTriggerType trigger}) async {
    for (final validator in validators) {
      final String? error = await validator.onTriggered(by: trigger, value: value);
      if (error != null) {
        errorController.value = error;
        return false;
      }
    }
    errorController.value = null;
    return true;
  }

  void _reevaluate() {
    final String value = textController.text;
    final String? error = errorController.value;
    _value = ValidataFieldValue<String>(value: value, error: error);
  }

  void _onTextChanged() {
    validate(trigger: ValidataTriggerType.onChange);
  }

  void _onFocusChanged() {
    final bool hasFocus = focusNode.hasFocus;
    if (hasFocus) {
      validate(trigger: ValidataTriggerType.onFocus);
    } else {
      validate(trigger: ValidataTriggerType.onUnfocus);
    }
  }
}
