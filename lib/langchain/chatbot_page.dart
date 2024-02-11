import 'package:finwise/langchain/langchain.dart';
import 'package:finwise/langchain/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatBotScreen extends StatefulHookConsumerWidget {
  const ChatBotScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends ConsumerState<ConsumerStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final conversationNotifier =
        ref.watch(conversationNotifierProvider.notifier);
    final messages = ref.watch(messagesNotifierProvider);
    final conversation = ref.watch(conversationNotifierProvider);
    debugPrint('Messages: $messages');
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SelectableText(conversation.value ?? ''),
              TextField(
                onSubmitted: (value) {
                  conversationNotifier.run(value);
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: messages.when(
                  data: (messages) => messages.length,
                  loading: () => 0,
                  error: (error, stackTrace) => 0,
                ),
                itemBuilder: (context, index) {
                  final message = messages.when(
                    data: (messages) => messages[index],
                    loading: () => null,
                    error: (error, stackTrace) => null,
                  );
                  return ListTile(
                    title: Text(message!.content),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
