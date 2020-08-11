String validateNonEmpty(String value) {
  if (value.length == 0)
    return 'field is required!';
  else
    return null;
}

String validateMinLength(String value, {int length = 3}) {
  if (value.length < length)
    return 'minimum $length character are required !';
  else
    return null;
}

String validatePhone(String value) {
  if (value.length < 11)
    return 'valid phone number is required !';
  else
    return null;
}

String validateEmail(String value) {
  if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value))
    return 'valid email is required !';
  else
    return null;
}

String validateWebsite(String value) {
  bool _validURL = Uri.parse(value).isAbsolute;

  if (!_validURL)
    return 'valid url is required!';
  else
    return null;
}
