import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pod_flutter/main.dart';
import 'package:pod_flutter/pages/general_page.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart' as auth;

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  // These fields hold the last result or error message that we've received from
  // the server or null if no result exists yet.
  String? _resultMessage;
  String? _errorMessage;

  String _buttonText = 'Login';

  late auth.EmailAuthController emailController;
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _verifyInputController = TextEditingController();

  bool _sentVerificationCode = false;

  @override
  void initState() {
    super.initState();
    emailController = auth.EmailAuthController(sessionManager.caller);
    sessionManager.addListener(() async {
      print('------------------------------------');
      print(sessionManager.signedInUser);
      print('KEY: ${await sessionManager.keyManager.get()}');
      print('------------------------------------');
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            auth.SignInWithEmailButton(caller: sessionManager.caller),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _emailInputController,
                decoration: const InputDecoration(
                  hintText: 'email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _passwordInputController,
                decoration: const InputDecoration(
                  hintText: 'pass',
                ),
              ),
            ),
            // if (_sentVerificationCode)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _verifyInputController,
                decoration: const InputDecoration(
                  hintText: 'verificationCode',
                ),
              ),
            ),
            if (!sessionManager.isSignedIn) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () async {
                    try {
                      _errorMessage = null;
                      final result = await emailController.signIn(
                        _emailInputController.text,
                        _passwordInputController.text,
                      );
                      _resultMessage = 'SIGNED IN ✅: ${result?.email}';
                    } catch (e, stack) {
                      print(e);
                      print(stack);
                    }
                    if (mounted) setState(() {});
                  },
                  child: const Text('Login'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () async {
                    try {
                      _errorMessage = null;
                      final sentCode = await emailController.createAccountRequest(
                        _emailInputController.text.split('@').first,
                        _emailInputController.text,
                        _passwordInputController.text,
                      );

                      _sentVerificationCode = sentCode;
                      if (mounted) setState(() {});
                    } catch (e, stack) {
                      print(e);
                      print(stack);
                    }
                    if (mounted) setState(() {});
                  },
                  child: const Text('Create Account'),
                ),
              ),
              // if (_sentVerificationCode)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () async {
                    try {
                      _errorMessage = null;
                      ;
                      final result = await emailController.validateAccount(
                        _emailInputController.text,
                        _verifyInputController.text,
                      );

                      final status = sessionManager.isSignedIn ? 'And is Signed In' : 'NOT Signed in';
                      _resultMessage = 'VALIDATED ACCOUNT ✅: ${result?.email} - $status';
                      if (mounted) setState(() {});
                    } catch (e, stack) {
                      print(e);
                      print(stack);
                    }
                    if (mounted) setState(() {});
                  },
                  child: const Text('Verify Account'),
                ),
              ),
            ],
            if (sessionManager.isSignedIn) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () async {
                    try {
                      _errorMessage = null;
                      await sessionManager.signOut();
                      if (mounted) setState(() {});
                    } catch (e, stack) {
                      print(e);
                      print(stack);
                    }
                    if (mounted) setState(() {});
                  },
                  child: const Text('Logout'),
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () async {
                  try {
                    final result = await client.premium.getPremiumData();
                    _resultMessage = result.toString();
                  } catch (e, stack) {
                    print(e);
                    print(stack);
                    _errorMessage = e.toString();
                  }
                  if (mounted) setState(() {});
                },
                child: const Text('get premium data'),
              ),
            ),
            ResultDisplay(
              resultMessage: _resultMessage,
              errorMessage: _errorMessage,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
