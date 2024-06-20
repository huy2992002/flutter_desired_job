import 'dart:math';

class Maths {
  static String genOtp(int length) {
    String value = '0123456789';
    String result = '';
    for (int i = 0; i < length; i++) {
      result = '$result${Random().nextInt(value.length)}';
    }
    return result;
  }

  static String randomUUid({int? length}) {
    const lowercaseLetter = 'qwertyuiopasdfghjklzxcvbnm';
    const uppercaseLetter = 'QWERTYUIOPASDFGHJKLZXCVBNM';
    const numbers = '0123456789';

    List<String> allChars =
        '$lowercaseLetter$uppercaseLetter$numbers'.split('');
    String value = '';
    for (var i = 0; i < (length ?? 10); i++) {
      int index = Random().nextInt(allChars.length);
      value = '$value${allChars[index]}';
    }
    return value;
  }
}
