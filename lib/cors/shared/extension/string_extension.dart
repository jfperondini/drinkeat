extension StringExtensions on String {
  String toReplaceCoinFormat(String text) => text.replaceAll(RegExp(r'[R\$,.]'), '');
}
