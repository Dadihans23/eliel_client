import 'package:flutter/material.dart';
import 'package:eliel_client/models/eventfuture.dart';

class FavoritesProvider with ChangeNotifier {
  List<Event> _favoriteEvents = [];

  List<Event> get favoriteEvents => _favoriteEvents;

  void toggleFavorite(Event event) {
    if (_favoriteEvents.contains(event)) {
      _favoriteEvents.remove(event);
    } else {
      _favoriteEvents.add(event);
    }
    notifyListeners(); // Notifie l'interface utilisateur du changement d'état
  }
  void clearFavorites(Event event) {
      _favoriteEvents.remove(event);
    notifyListeners(); // Notifie l'interface utilisateur du changement d'état
  }

  bool isFavorite(Event event) {
    if (_favoriteEvents.contains(event)) {
      return true;
    }
    return  false;
  }
}
