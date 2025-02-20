import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _username ;

  // Fonction pour définir le token
  void setToken(String token) {
    _token = token;
    notifyListeners();
  }
  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }
  void clearToken(){
    _token = null;
    notifyListeners();
  }

  // Fonction pour récupérer le token
  String? getToken() {
    return _token;
  }
   String? getUsername() {
    return _username;
  }
}
