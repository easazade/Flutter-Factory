import 'dart:io';

/// return an environment variable with the given [key] if exists
String? envVar(String key) => Platform.environment[key];
int? envIntVar(String key) => int.tryParse(envVar(key) ?? '');
bool envBoolVar(String key) => envVar(key) == 'true';
