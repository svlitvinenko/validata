final class ValidataFieldValue<T extends Object> {
  final T value;
  final String? error;

  ValidataFieldValue({required this.value, required this.error});
}
