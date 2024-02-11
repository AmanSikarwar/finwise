import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:finwise/auth/auth_state.dart';
import 'package:finwise/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AuthState> {
  Future<void> checkAuth() async {
    final account = ref.read(accountProvider);
    final sessions = await account.getSession(sessionId: 'current');
    if (sessions.current) {
      state = const AsyncData(AuthState.authenticated);
    } else {
      state = const AsyncData(AuthState.unauthenticated);
    }
    log('Auth state: $state');
  }

  Future<String> sendOTP(String number) async {
    final account = ref.read(accountProvider);
    final sessionToken = await account.createPhoneSession(
      userId: ID.unique(),
      phone: number,
    );

    return sessionToken.userId;
  }

  void loginWithOTP(String userId, String otp) async {
    try {
      final account = ref.read(accountProvider);
      await account.updatePhoneSession(
        userId: userId,
        secret: otp,
      );

      final user = await account.get();

      if (user.phoneVerification) {
        state = const AsyncData(AuthState.authenticated);
      } else {
        state = const AsyncData(AuthState.unauthenticated);
      }
    } on Exception catch (e) {
      log('Exception: $e');
    }
  }

  Future<void> logout() async {
    final account = ref.read(accountProvider);
    await account.deleteSession(sessionId: 'current');
    state = const AsyncData(AuthState.unauthenticated);
  }

  @override
  AuthState build() {
    return AuthState.uninitialized;
  }
}
