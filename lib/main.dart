import 'package:finwise/auth/auth_screen.dart';
import 'package:finwise/screens/choice_screen.dart';
import 'package:finwise/langchain/chatbot_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final theme = ThemeData(
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.white,
    secondary: Colors.blue[800],
  ),
);

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
  // conversationTest();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const AuthScreen(),
      title: 'FinWise App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
