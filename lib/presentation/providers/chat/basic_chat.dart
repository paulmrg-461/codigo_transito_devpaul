import 'package:codigo_transito_devpaul/infrastructure/services/gemini_service.dart';
import 'package:codigo_transito_devpaul/presentation/providers/users/user_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

import 'package:codigo_transito_devpaul/presentation/providers/chat/is_gemini_writing.dart';
import 'package:codigo_transito_devpaul/infrastructure/local/chat_storage.dart';

part 'basic_chat.g.dart';

final uuid = Uuid();

@riverpod
class BasicChat extends _$BasicChat {
  @override
  List<Message> build() {
    Future(() async {
      final user = ref.read(userProvider);
      final geminiUser = ref.read(geminiUserProvider);
      User resolve(String id) => id == geminiUser.id ? geminiUser : user;
      final loaded = await ChatStorage.loadMessages(resolve);
      if (loaded.isNotEmpty) {
        state = loaded;
      }
    });
    return [];
  }

  void addMessage({required PartialText partialText, required User user}) {
    // Todo: agregar condición cuando vengan imágenes
    // if ... else if switch

    _addTextMessage(partialText, user);
  }

  void _addTextMessage(PartialText partialText, User author) {
    final message = TextMessage(
      id: uuid.v4(),
      author: author,
      text: partialText.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
    ChatStorage.saveMessages(state);
    _geminiTextResponse(partialText.text);
  }

  void _geminiTextResponse(String prompt) async {
    final isGeminiWriting = ref.read(isGeminiWritingProvider.notifier);
    final geminiUser = ref.read(geminiUserProvider);
    isGeminiWriting.setIsWriting();

    try {
      final response = await GeminiService.sendMessage(prompt);

      isGeminiWriting.setIsNotWriting();

      final message = TextMessage(
        id: uuid.v4(),
        author: geminiUser,
        text: response,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      state = [message, ...state];
      ChatStorage.saveMessages(state);
    } catch (e) {
      isGeminiWriting.setIsNotWriting();

      final errorMessage = TextMessage(
        id: uuid.v4(),
        author: geminiUser,
        text: 'Error al procesar tu consulta: $e',
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      state = [errorMessage, ...state];
      ChatStorage.saveMessages(state);
    }
  }
}
