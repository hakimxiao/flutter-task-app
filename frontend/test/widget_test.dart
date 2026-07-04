import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/auth/cubit/auth_cubit.dart';
import 'package:frontend/features/auth/pages/sign_up_page.dart';

void main() {
  testWidgets('Sign up page renders inside Material app', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => AuthCubit(),
        child: const MaterialApp(home: SignUpPage()),
      ),
    );

    expect(find.text('Sign Up.'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text('SIGN UP NOW'), findsOneWidget);
  });
}
