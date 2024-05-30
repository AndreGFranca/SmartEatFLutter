class DefaultValidators{
  static bool textValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  static bool numberValidator(String? value) {

    if (!textValidator(value)) {
      if (double.parse(value!) > 0) {
        return false;
      }
    }
    return true;
  }
}