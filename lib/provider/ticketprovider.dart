import 'package:eliel_client/models/ticket.dart';
import 'package:flutter/material.dart';

class TicketProvider with ChangeNotifier {
  List<Ticket> AllTicket = [];

  List<Ticket> get NumberTicket => AllTicket;

  void toggleTicket(Ticket event) {
    if (AllTicket.contains(event)) {
      AllTicket.remove(event);
    } else {
      AllTicket.add(event);
    }
    notifyListeners(); // Notifie l'interface utilisateur du changement d'état
  }
  void clearTickets(Ticket event) {
      AllTicket.remove(event);
    notifyListeners(); // Notifie l'interface utilisateur du changement d'état
  }

  bool isTicket(Ticket event) {
    if (AllTicket.contains(event)) {
      return true;
    }
    return  false;
  }
}
