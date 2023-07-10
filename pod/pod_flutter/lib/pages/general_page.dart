import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pod_client/pod_client.dart';
import 'package:pod_flutter/main.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  GeneralPageState createState() => GeneralPageState();
}

class GeneralPageState extends State<GeneralPage> {
  // These fields hold the last result or error message that we've received from
  // the server or null if no result exists yet.
  String? _resultMessage;
  String? _carResultMessage;
  String? _userResult;
  String? _createUserResult;
  String? _errorMessage;
  String? _findUserByIdResult;

  final _textEditingController = TextEditingController();

  // Calls the `hello` method of the `example` endpoint. Will set either the
  // `_resultMessage` or `_errorMessage` field, depending on if the call
  // is successful.
  void _sendRequest() async {
    try {
      final todo = Todo(name: _textEditingController.text, isDone: false);
      final result = await client.todo.createTodo(todo);
      final carResult = await client.car.getCar();
      final createUserResult = await client.user.createUser(_textEditingController.text);
      final findUserResult = await client.user.getUserById(createUserResult.id!);

      try {
        _userResult = await client.user.user('name');
      } on AppException catch (e) {
        _userResult = '${e.message} | ${e.type.name}';
      }
      setState(() {
        _errorMessage = null;
        _resultMessage = jsonEncode(result.toJson());
        _carResultMessage = carResult.name;
        _createUserResult = 'created a user => ${jsonEncode(createUserResult)}';
        _findUserByIdResult = 'found this user $findUserResult';
      });
    } catch (e, _) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: _sendRequest,
                child: const Text('Send Request'),
              ),
            ),
            ResultDisplay(
              resultMessage: _resultMessage,
              errorMessage: _errorMessage,
            ),
            const SizedBox(height: 20),
            ResultDisplay(
              resultMessage: _carResultMessage,
            ),
            const SizedBox(height: 20),
            ResultDisplay(
              resultMessage: _userResult,
            ),
            const SizedBox(height: 20),
            ResultDisplay(
              resultMessage: _createUserResult,
            ),
            const SizedBox(height: 20),
            ResultDisplay(
              resultMessage: _findUserByIdResult,
            ),
          ],
        ),
      ),
    );
  }
}

// _ResultDisplays shows the result of the call. Either the returned result from
// the `example.hello` endpoint method or an error message.
class ResultDisplay extends StatelessWidget {
  final String? resultMessage;
  final String? errorMessage;

  const ResultDisplay({
    super.key,
    this.resultMessage,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    String text;
    Color backgroundColor;
    if (errorMessage != null) {
      backgroundColor = Colors.red[300]!;
      text = errorMessage!;
    } else if (resultMessage != null) {
      backgroundColor = Colors.green[300]!;
      text = resultMessage!;
    } else {
      backgroundColor = Colors.grey[300]!;
      text = 'No server response yet.';
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: backgroundColor,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
