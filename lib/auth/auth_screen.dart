import 'dart:developer';

import 'package:finwise/auth/auth_provider.dart';
import 'package:finwise/auth/auth_state.dart';
import 'package:finwise/langchain/chatbot_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mobileNumberController = useTextEditingController();
    final otpController = useTextEditingController();
    final userIdController = useTextEditingController();
    final authState = ref.watch(authProvider);
    // ref.read(authProvider.notifier).checkAuth();
    if (authState.value == AuthState.authenticated) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ChatBotScreen(),
      ));
      return const Scaffold(
        body: Center(
          child: Text('Authenticated!}'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Screen'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: mobileNumberController,
            decoration: const InputDecoration(
              labelText: 'Mobile Number',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(authProvider.notifier)
                  .sendOTP(
                    mobileNumberController.text,
                  )
                  .then((value) => userIdController.text = value);
            },
            child: const Text('Send OTP'),
          ),
          TextField(
            controller: otpController,
            decoration: const InputDecoration(
              labelText: 'OTP',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(authProvider.notifier).loginWithOTP(
                    userIdController.text,
                    otpController.text,
                  );
            },
            child: const Text('Verify OTP'),
          ),
        ],
      )),
    );
  }
}
