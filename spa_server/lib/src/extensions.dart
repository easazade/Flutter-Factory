extension StringExt on String? {
  bool get isSet =>
      this != null && this != 'null' && (this?.trim().isNotEmpty ?? false);
  bool get isNotSet => !isSet;
}
