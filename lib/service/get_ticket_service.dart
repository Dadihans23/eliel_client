import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eliel_client/models/ticket.dart';
import 'package:eliel_client/util/constant.dart';
import 'package:provider/provider.dart';
import 'package:eliel_client/provider/ticketprovider.dart ' ;


final ticket = Provider.of<TicketProvider>;
String baseUrl = Constants.adresse;


  String adresse =baseUrl;  // Adresse du serveur


// Fonction pour récupérer les tickets depuis l'API
Future<List<Ticket>> fetchTickets(String token) async {

    if(token == null) {
      throw Exception('Token non fourni');
    }

    final response = await http.post(
      Uri.parse('http://$adresse:8000/users/user/tickets/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'token': token ,
        // 'token': '7357ab64-16dd-435d-8cf4-0d88e951fc5c' ,

      }),
    );

  if (response.statusCode == 200) {
    print("zoo");
    print(response.body);
    // Décoder le JSON et le convertir en liste de tickets
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Ticket.fromJson(json)).toList();
  }
   else if (response.statusCode == 204) {
    print(token);
    print(response.statusCode) ;
    print(response.body);
    return [];
    // throw Exception('Aucun ticket achété'); // Cette exception sera attrapée dans le FutureBuilder
  }
   else {
    print(token);
    print(response.statusCode) ;
    print(response.body);
    throw Exception('Erreur de serveur');
  }
}
