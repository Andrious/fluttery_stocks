// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

///
final messages = MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

///
typedef MessageIfAbsent = Function(String message_str, List args);

///
class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'en';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        'market': MessageLookupByLibrary.simpleMessage('MARKET'),
        'portfolio': MessageLookupByLibrary.simpleMessage('PORTFOLIO'),
        'title': MessageLookupByLibrary.simpleMessage('Stocks'),
      };
}
