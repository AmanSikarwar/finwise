import 'dart:async';

import 'package:finwise/models/message.dart';
import 'package:finwise/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesNotifier extends AsyncNotifier<List<Message>> {
  Future<void> addMessage(Message message) async {
    try {
      final database = ref.read(databaseProvider);
      final account = ref.read(accountProvider);
      final currentUser = await account.get();
      final messages = state.value!;

      await database.createDocument(
        databaseId: 'database1',
        collectionId: 'messages',
        documentId: '${currentUser.$id}-${message.id}',
        data: message.toMap(),
      );

      messages.add(message);
      state = AsyncData(messages);
    } on Exception catch (e) {
      debugPrint('Exception: $e');
    }
  }

  Future<void> removeMessage(String messageId) async {
    final database = ref.read(databaseProvider);
    final account = ref.read(accountProvider);
    final currentUser = await account.get();
    final messages = state.value!;

    await database.deleteDocument(
      databaseId: 'database1',
      collectionId: 'messages',
      documentId: '${currentUser.$id}-$messageId',
    );

    messages.removeWhere((message) => message.id == messageId);
    state = AsyncData(messages);
  }

  Future<void> clearMessages() async {
    final database = ref.read(databaseProvider);
    final account = ref.read(accountProvider);
    final currentUser = await account.get();

    for (final message in state.value!) {
      await database.deleteDocument(
        databaseId: 'database1',
        collectionId: 'messages',
        documentId: '${currentUser.$id}-${message.id}',
      );
    }

    state = const AsyncData([]);
  }

  @override
  FutureOr<List<Message>> build() async {
    final database = ref.read(databaseProvider);
    final account = ref.read(accountProvider);
    final currentUser = await account.get();

    final response = await database.listDocuments(
      databaseId: 'database1',
      collectionId: 'messages',
      queries: [
        'documentId=${currentUser.$id}-',
      ],
    );

    final messages = response.documents
        .map((document) => Message.fromMap(document.data))
        .toList();

    return messages;
  }
}

final messagesNotifierProvider =
    AsyncNotifierProvider<MessagesNotifier, List<Message>>(
        MessagesNotifier.new);
