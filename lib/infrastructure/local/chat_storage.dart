import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class ChatStorage {
  static const String boxName = 'basic_chat_box';
  static const String keyMessages = 'messages';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Box get _box => Hive.box(boxName);

  static Future<void> saveMessages(List<Message> messages) async {
    final list = messages.map(_toMap).toList();
    await _box.put(keyMessages, list);
  }

  static Future<List<Message>> loadMessages(User Function(String) resolveUser) async {
    final data = _box.get(keyMessages);
    if (data is List) {
      return data
          .map((e) => Map<String, dynamic>.from(e as Map))
          .map((m) => _fromMap(m, resolveUser))
          .toList();
    }
    return [];
  }

  static Map<String, dynamic> _toMap(Message message) {
    if (message is TextMessage) {
      return {
        'type': 'text',
        'id': message.id,
        'authorId': message.author.id,
        'text': message.text,
        'createdAt': message.createdAt,
      };
    }
    return {
      'type': 'unknown',
      'id': message.id,
      'authorId': message.author.id,
      'createdAt': message.createdAt,
    };
  }

  static Message _fromMap(Map<String, dynamic> map, User Function(String) resolveUser) {
    final type = map['type'] as String? ?? 'text';
    final authorId = map['authorId'] as String? ?? '';
    final author = resolveUser(authorId);
    if (type == 'text') {
      return TextMessage(
        id: map['id'] as String,
        author: author,
        text: map['text'] as String? ?? '',
        createdAt: map['createdAt'] as int?,
      );
    }
    return TextMessage(
      id: map['id'] as String,
      author: author,
      text: '',
      createdAt: map['createdAt'] as int?,
    );
  }
}
