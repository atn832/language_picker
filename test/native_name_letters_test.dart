import 'package:flutter_test/flutter_test.dart';
import 'package:language_picker/languages.dart';

final _word = RegExp(r'[\p{L}\p{M}]+', unicode: true);
final _latin = RegExp(r'\p{Script=Latin}', unicode: true);
final _cyrillicOrGreek =
    RegExp(r'[\p{Script=Cyrillic}\p{Script=Greek}]', unicode: true);

void main() {
  test('no native name mixes Latin with Cyrillic or Greek letters', () {
    // Ossetian is commonly written with the Latin æ (as in CLDR).
    const allowed = {'æвзаг'};
    final bad = <String>[];
    for (final language in Languages.defaultLanguages) {
      for (final m in _word.allMatches(language.nativeName)) {
        final w = m.group(0)!;
        if (_latin.hasMatch(w) &&
            _cyrillicOrGreek.hasMatch(w) &&
            !allowed.contains(w)) {
          bad.add('${language.isoCode}: $w');
        }
      }
    }
    expect(bad, isEmpty);
  });
}
