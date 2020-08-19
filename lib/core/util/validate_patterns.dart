class PatternUtils {
  static const String _email_pattern =
      r"^^[a-zA-Z0-9.!#$%&*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";

  static bool emailIsValid({String email}) {
    RegExp emailRegularExpression = RegExp(_email_pattern);
    if (emailRegularExpression.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }
}
