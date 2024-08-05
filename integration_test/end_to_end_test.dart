import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/features/auth/auth_bloc_test.dart';
import '../test/features/chat/chat_bloc_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end tests', () {
    final userRepository = UserRepositoryMock();
    final chatRepository = ChatRepositoryMock();
    final authRepository = AuthRepositoryMock();

    testWidgets('Login with test account', (tester) async {
      await tester.pumpWidget(MyApp(authRepository: authRepository, chatRepository: chatRepository, userRepository: userRepository));

      await tester.enterText(find.byKey(const ValueKey('login_email')), 'test@test.com');
      await tester.enterText(find.byKey(const ValueKey('login_password')), 'test123');

      await tester.tap(find.byKey(const ValueKey('login_login_button')));

      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('home_title')), findsOneWidget);
    });

    testWidgets('Login with wrong credentials displays an error', (tester) async {
      await tester.pumpWidget(MyApp(authRepository: authRepository, chatRepository: chatRepository, userRepository: userRepository));

      await tester.enterText(find.byKey(const ValueKey('login_email')), 'test@test.com');
      await tester.enterText(find.byKey(const ValueKey('login_password')), 'wrong_password');

      await tester.tap(find.byKey(const ValueKey('login_login_button')));

      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('login_error_message')), findsOneWidget);
    });
  });
}
