import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codigo_transito_devpaul/presentation/providers/chat/basic_chat.dart';

import 'package:codigo_transito_devpaul/presentation/providers/chat/is_gemini_writing.dart';
import 'package:codigo_transito_devpaul/presentation/providers/users/user_provider.dart';

class BasicPromptScreen extends ConsumerWidget {
  const BasicPromptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geminiUser = ref.watch(geminiUserProvider);
    final user = ref.watch(userProvider);
    final isGeminiWriting = ref.watch(isGeminiWritingProvider);
    final chatMessages = ref.watch(basicChatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asistente de Tránsito'),
        actions: [
          IconButton(
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Borrar historial'),
                  content: const Text('¿Deseas borrar todo el historial?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
                    TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Borrar')),
                  ],
                ),
              );
              if (confirmed == true) {
                ref.read(basicChatProvider.notifier).clearAll();
              }
            },
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Borrar historial',
          ),
        ],
      ),
      body: Chat(
        messages: chatMessages,

        // On Send Message
        onSendPressed: (types.PartialText partialText) {
          final basicChatNotifier = ref.read(basicChatProvider.notifier);
          basicChatNotifier.addMessage(partialText: partialText, user: user);
        },
        onMessageLongPress: (context, message) async {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Borrar mensaje'),
              content: const Text('¿Deseas borrar este mensaje?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
                TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Borrar')),
              ],
            ),
          );
          if (confirmed == true) {
            ref.read(basicChatProvider.notifier).deleteMessage(message.id);
          }
        },
        user: user,
        theme: DarkChatTheme(),
        showUserNames: true,

        // showUserAvatars: true,
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers: isGeminiWriting ? [geminiUser] : [],
          customTypingWidget: const Center(
            child: Text('Procesando consulta...'),
          ),
        ),
      ),
    );
  }
}
