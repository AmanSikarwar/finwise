import 'dart:async';

import 'package:finwise/langchain/message_provider.dart';
import 'package:finwise/models/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_google/langchain_google.dart';

String extractContent(String message) {
  final pattern = RegExp(r'content: (.*),');
  final match = pattern.firstMatch(message);
  if (match != null) {
    return match.group(1)!;
  } else {
    return '';
  }
}

final llmProvider = Provider((ref) {
  final llm =
      ChatGoogleGenerativeAI(apiKey: 'AIzaSyBzp2tpXUqnVRlr_UmZry3wUAsvN3344kM');

  return llm;
});

class ConversationNotifier extends AsyncNotifier<String> {
  @override
  FutureOr<String> build() {
    final conversation = ref.read(conversationProvider);
    return conversation.inputKeys.join('\n');
  }

  Future<void> run(String value) async {
    final messagesProvider = ref.read(messagesNotifierProvider.notifier);
    final userMessage = Message(
      id: DateTime.now().toIso8601String(),
      content: value,
      type: MessageType.user,
    );
    await messagesProvider.addMessage(userMessage);
    state = AsyncData('${state.value!}\n$value');
    final conversation = ref.watch(conversationProvider);
    final output = await conversation.call(value, returnOnlyOutputs: true);
    final message = output["response"] as AIChatMessage?;
    if (message != null) {
      final botMessage = Message(
        id: DateTime.now().toIso8601String(),
        content: message.content,
        type: MessageType.bot,
      );
      await messagesProvider.addMessage(botMessage);
      state = AsyncData('${state.value!}\n${message.content}');
    }
  }
}

final conversationNotifierProvider =
    AsyncNotifierProvider<ConversationNotifier, String>(
        ConversationNotifier.new);

final conversationProvider = Provider((ref) {
  final llm = ref.read(llmProvider);

  final promptTemplate = SystemChatMessagePromptTemplate.fromTemplate(
    '''
    You are an expert Financial advisor. You understand best practices in financial planning specially for the people of India. You also know more than 10 Indian languages, so you can interact with people in their own language. You are a great listener and you can understand the needs of your clients. You are also a great speaker and can explain complex financial concepts in a simple way. You are a great problem solver.

    You are meeting a client for the first time.
    The client is a {client_age} year old.
    The client is a {client_profession}.
    The client's marital status is {client_marital_status}.
    The client has {client_children} children.
    The client's annual income is {client_income} INR.
    The client's financial goals are {client_goals}.
    The client's risk tolerance is {client_risk_tolerance}.
    The client's investment knowledge is {client_investment_knowledge}.
    The client's investment experience is {client_investment_experience}.

    You have to understand the client's financial situation and provide the best financial advice to the client.

    If you need any information from the client, you can ask the client for the information (one by one).

    You have to ask and respond to the client in client's preferred language.

    You can determine the client's preferred language from client's first message or you can ask the client for the preferred language.

    Now, start the conversation with the client.
  ''',
  );

  final promptText = promptTemplate.format({
    'client_age': '30',
    'client_profession': 'Software Engineer',
    'client_marital_status': 'Married',
    'client_children': '2',
    'client_income': '10,00,000',
    'client_goals': 'Retirement, Child Education, Child Marriage',
    'client_risk_tolerance': 'High',
    'client_investment_knowledge': 'Low',
    'client_investment_experience': 'None',
  });

  final conversation = ConversationChain(
    llm: llm,
    memory: ConversationBufferMemory(),
  );

  conversation.run(promptText);

  return conversation;
});

ConversationChain conversationTest() {
  final llm =
      ChatGoogleGenerativeAI(apiKey: 'AIzaSyBzp2tpXUqnVRlr_UmZry3wUAsvN3344kM');

  final promptTemplate = SystemChatMessagePromptTemplate.fromTemplate(
    '''
    You are an expert Financial advisor. You understand best practices in financial planning specially for the people of India. You also know more than 10 Indian languages, so you can interact with people in their own language. You are a great listener and you can understand the needs of your clients. You are also a great speaker and can explain complex financial concepts in a simple way. You are a great problem solver.

    You are meeting a client for the first time.
    The client is a {client_age} year old.
    The client is a {client_profession}.
    The client's marital status is {client_marital_status}.
    The client has {client_children} children.
    The client's annual income is {client_income} INR.
    The client's financial goals are {client_goals}.
    The client's risk tolerance is {client_risk_tolerance}.
    The client's investment knowledge is {client_investment_knowledge}.
    The client's investment experience is {client_investment_experience}.

    You have to understand the client's financial situation and provide the best financial advice to the client.

    If you need any information from the client, you can ask the client for the information.

    You have to ask and respond to the client in client's preferred language.

    You can determine the client's preferred language from client's first message or you can ask the client for the preferred language.

    Now, start the conversation with the client.
  ''',
  );

  final promptText = promptTemplate.format({
    'client_age': '30',
    'client_profession': 'Software Engineer',
    'client_marital_status': 'Married',
    'client_children': '2',
    'client_income': '10,00,000',
    'client_goals': 'Retirement, Child Education, Child Marriage',
    'client_risk_tolerance': 'High',
    'client_investment_knowledge': 'Low',
    'client_investment_experience': 'None',
  });

  final conversation = ConversationChain(
    llm: llm,
    memory: ConversationBufferMemory(),
  );

  conversation.run(promptText);

  return conversation;
}
