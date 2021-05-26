import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  File? _avatar;
  String? _login;

  File? get avatar => _avatar;

  String get login => _login ?? '';

  void setAvatar(File? image) {
    _avatar = image;
    notifyListeners();
  }

  void setLogin(String login) {
    _login = login;
    notifyListeners();
  }
}

@immutable
class Settings {
  final File avatar;
  final String login;

  Settings({
    required this.avatar,
    required this.login,
  });
}