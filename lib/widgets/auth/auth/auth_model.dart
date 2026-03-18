import 'dart:async';

import 'package:drive_test_ui/domain/api_client.dart';
import 'package:drive_test_ui/domain/data_providers/session_data_provider.dart';
import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final loginTextController = TextEditingController();
  final passwwordTextController = TextEditingController();
  String? _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  String? get errorMessage => _errorMessage;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwwordTextController.text;
    _errorMessage = null;
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Login and password can not be empty';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    String? sessionId;
    notifyListeners();
    try {
      sessionId = await _apiClient.auth(username: login, password: password);
    } catch (error) {
      _errorMessage = 'Auth error: $error';
    }
    // sessionId = await _apiClient
    //     .auth(username: login, password: password)
    //     .catchError((error) {
    //       _errorMessage = 'Auth error: $error';
    //       notifyListeners();
    //     });
    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null) {
      _errorMessage = 'Unknown error';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    //_sessionDataProvider.sessionId = sessionId;
    unawaited(Navigator.of(context).pushReplacementNamed('/main_screen'));
  }

  // String? get email => _email;
  // String? get password => _password;

  // void setEmail(String email) {
  //   _email = email;
  //   notifyListeners();
  // }

  // void setPassword(String password) {
  //   _password = password;
  //   notifyListeners();
  // }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;

  const AuthProvider({Key? key, required this.model, required Widget child})
    : super(key: key, notifier: model, child: child);

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<AuthProvider>()
        ?.widget;
    return widget is AuthProvider ? widget : null;
  }

  // static AuthModel of(BuildContext context) {
  //   final provider =
  //       context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  //   if (provider == null) {
  //     throw Exception('No AuthProvider found in context');
  //   }
  //   return provider.model;
  // }
}
