// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

///
final messages = MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

///
// ignore: non_constant_identifier_names
typedef MessageIfAbsent = void Function(String message_str, List args);

///
class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'es';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        'market': MessageLookupByLibrary.simpleMessage('MERCADO'),
        'portfolio': MessageLookupByLibrary.simpleMessage('CARTERA'),
        'title': MessageLookupByLibrary.simpleMessage('Acciones'),
      };
}
