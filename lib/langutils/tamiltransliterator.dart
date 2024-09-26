import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

import 'mapper.dart';

class TamilTransliterator {
  final Mapper mapper;

  static const Map<String, Map<String, List<String>>> charmap = {
    'independent_vowels': {
      '\u0B85': ['அ', 'A'],
      '\u0B86': ['ஆ ', 'AA'],
      '\u0B87': ['இ', 'I'],
      '\u0B88': ['ஈ', 'II'],
      '\u0B89': ['உ', 'U'],
      '\u0B8A': ['ஊ', 'UU'],
      '\u0B8B': ['', '<reserved>'],
      '\u0B8C': ['', '<reserved>'],
      '\u0B8D': ['', '<reserved>'],
      '\u0B8E': ['எ', 'E'],
      '\u0B8F': ['ஏ', 'EE'],
      '\u0B90': ['ஐ', 'AI'],
      '\u0B91': ['', '<reserved>'],
      '\u0B92': ['ஒ', 'O'],
      '\u0B93': ['ஓ', 'OO'],
      '\u0B94': ['ஔ ', 'AU'],
    },
    'consonants': {
      '\u0B95': ['க', 'KA'],
      '\u0B96': ['', '<reserved>'],
      '\u0B97': ['', '<reserved>'],
      '\u0B98': ['', '<reserved>'],
      '\u0B99': ['ங', 'NGA'],
      '\u0B9A': ['ச', 'SA'],
      '\u0B9B': ['', '<reserved>'],
      '\u0B9C': ['ஜ', 'JA'],
      '\u0B9D': ['', '<reserved>'],
      '\u0B9E': ['ஞ', 'NYA'],
      '\u0B9F': ['ட', 'DA'],
      '\u0BA0': ['', '<reserved>'],
      '\u0BA1': ['', '<reserved>'],
      '\u0BA2': ['', '<reserved>'],
      '\u0BA3': ['ண', 'NNA'],
      '\u0BA4': ['த', 'THA'],
      '\u0BA5': ['', '<reserved>'],
      '\u0BA6': ['', '<reserved>'],
      '\u0BA7': ['', '<reserved>'],
      '\u0BA8': ['ந', 'NA'],
      '\u0BA9': ['ன', 'NA'],
      '\u0BAA': ['ப', 'PA'],
      '\u0BAB': ['', '<reserved>'],
      '\u0BAC': ['', '<reserved>'],
      '\u0BAD': ['', '<reserved>'],
      '\u0BAE': ['ம', 'MA'],
      '\u0BAF': ['ய', 'YA'],
      '\u0BB0': ['ர', 'RA'],
      '\u0BB1': ['ற', 'RRA'],
      '\u0BB2': ['ல', 'LA'],
      '\u0BB3': ['ள', 'LLA'],
      '\u0BB4': ['ழ', 'LLLA'],
      '\u0BB5': ['வ', 'VA'],
      '\u0BB6': ['ஶ', 'SHA'],
      '\u0BB7': ['ஷ', 'SSA'],
      '\u0BB8': ['ஸ', 'SA'],
      '\u0BB9': ['ஹ', 'HA'],
    },
    'dependent_vowels_right': {
      '\u0BBE': ['\$ா', 'AA'],
      '\u0BBF': ['\$ி', 'I'],
      '\u0BC0': ['\$ீ', 'II'],
      '\u0BC1': ['\$ு', 'U'],
      '\u0BC2': ['ஊ\$', 'UU'],
      '\u0BC3': ['', '<reserved>'],
      '\u0BC4': ['', '<reserved>'],
      '\u0BC5': ['', '<reserved>'],
    },
    'dependent_vowels_left': {
      '\u0BC6': ['\$ெ', 'E'],
      '\u0BC7': ['\$ே', 'EE'],
      '\u0BC8': ['\$ை', 'AI'],
    },
    'dependent_vowels_two_part': {
      '\u0BCA': ['\$ொ', 'O'],
      '\u0BCB': ['\$ோ', 'OO'],
      '\u0BCC': ['\$ௌ', 'AU'],
    },
    'pulli': {
      '\u0BCD': ['\$்', 'PULLI'],
    },
    'various_signs': {
      '\u0BD0': ['ௐ', 'OM'],
      '\u0BD1': ['"', '<reserved>'],
      '\u0BD2': ['"', '<reserved>'],
      '\u0BD3': ['"', '<reserved>'],
      '\u0BD4': ['"', '<reserved>'],
      '\u0BD5': ['"', '<reserved>'],
      '\u0BD6': ['"', '<reserved>'],
      '\u0BD7': ['\$ௗ', 'AU'],
      '\n': ['\n', '\n']
    },
    'punctuation': {
      '.': ['.', '.'],
      ',': [',', ','],
      '!': ['!', '!'],
      '?': ['?', '?'],
      ':': [':', ':'],
      ';': [';', ';'],
      '-': ['-', '-'],
      '—': ['—', '—'],
      '(': ['(', '('],
      ')': [')', ')'],
      '"': ['"', '"'],
      '\'': ['\'', '\''],
    },
    'english_alphabets': {
      'A': ['A', 'A'],
      'B': ['B', 'B'],
      'C': ['C', 'C'],
      'D': ['D', 'D'],
      'E': ['E', 'E'],
      'F': ['F', 'F'],
      'G': ['G', 'G'],
      'H': ['H', 'H'],
      'I': ['I', 'I'],
      'J': ['J', 'J'],
      'K': ['K', 'K'],
      'L': ['L', 'L'],
      'M': ['M', 'M'],
      'N': ['N', 'N'],
      'O': ['O', 'O'],
      'P': ['P', 'P'],
      'Q': ['Q', 'Q'],
      'R': ['R', 'R'],
      'S': ['S', 'S'],
      'T': ['T', 'T'],
      'U': ['U', 'U'],
      'V': ['V', 'V'],
      'W': ['W', 'W'],
      'X': ['X', 'X'],
      'Y': ['Y', 'Y'],
      'Z': ['Z', 'Z'],
      'a': ['a', 'a'],
      'b': ['b', 'b'],
      'c': ['c', 'c'],
      'd': ['d', 'd'],
      'e': ['e', 'e'],
      'f': ['f', 'f'],
      'g': ['g', 'g'],
      'h': ['h', 'h'],
      'i': ['i', 'i'],
      'j': ['j', 'j'],
      'k': ['k', 'k'],
      'l': ['l', 'l'],
      'm': ['m', 'm'],
      'n': ['n', 'n'],
      'o': ['o', 'o'],
      'p': ['p', 'p'],
      'q': ['q', 'q'],
      'r': ['r', 'r'],
      's': ['s', 's'],
      't': ['t', 't'],
      'u': ['u', 'u'],
      'v': ['v', 'v'],
      'w': ['w', 'w'],
      'x': ['x', 'x'],
      'y': ['y', 'y'],
      'z': ['z', 'z'],
    }
  };


  TamilTransliterator() : mapper = Mapper(charmap);

  String transliterate(String htmlText) {
    var document = html_parser.parse(htmlText);
    var body = document.body;
    if (body == null) return '';
    print(_transliterateNode(body).replaceAll('</br>', ''));
    return _transliterateNode(body).trim().replaceAll('</br>', '');
  }

  String _transliterateNode(dom.Node node) {
    var output = <String>[];
    for (var child in node.nodes) {
      if (child is dom.Text) {
        output.add(_transliterateText(child.text));
      } else if (child is dom.Element) {
        var tagName = child.localName;
        output.add('<$tagName>');
        output.add(_transliterateNode(child));
        output.add('</$tagName>');
      }
    }
    return _normalizeWhitespace(output.join(''));
  }

  String _transliterateText(String text) {
    var output = <String>[];
    var currentText = <String>[];

    for (var c in text.split('')) {
      if (_isTamilCharacter(c)) {
        currentText.add(c);
      } else {
        if (currentText.isNotEmpty) {
          output.add(_capitalizeFirstLetterOfWords(toEnglish(currentText.join(''))));
          currentText.clear();
        }
        output.add(c);
      }
    }

    if (currentText.isNotEmpty) {
      output.add(_capitalizeFirstLetterOfWords(toEnglish(currentText.join(''))));
    }

    return _normalizeWhitespace(output.join(''));
  }

  String _normalizeWhitespace(String text) {
    // Replace multiple spaces with a single space
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    // Remove leading and trailing whitespace
    return text.trim();
  }

  String _capitalizeFirstLetterOfWords(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  String toEnglish(String text) {
    text = _preprocess(text);
    var output = <String>[];

    for (var c in text.split('')) {
      var inEnglish = mapper.inEnglish(c);
      var tuple = mapper.charType(c);
      var parentType = tuple[0];
      var subType = tuple[1];

      if (parentType == 'pulli') {
        if (output.isNotEmpty) {
          output.removeLast();
        }
      } else if (parentType == 'vowels' && subType != 'independent_vowels') {
        if (output.isNotEmpty) {
          output.removeLast();
        }
        output.addAll(inEnglish.split(''));
      } else {
        output.addAll(inEnglish.split(''));
      }
    }

    return output.join('');
  }

  bool _isTamilCharacter(String c) {
    return (c.codeUnitAt(0) >= 0x0B80 && c.codeUnitAt(0) <= 0x0BFF);
  }

  String _preprocess(String text) {
    return text;
  }
}
