class StringConstants {
  factory StringConstants() {
    return _singleton;
  }

  StringConstants._internal();
  static final StringConstants _singleton = StringConstants._internal();

  final String publishableKey = "rzp_test_tMk9A0npsXwmgF";
  final String secretKey = "iCrhs0ECiPDyPTroYFB39zDf";
}
