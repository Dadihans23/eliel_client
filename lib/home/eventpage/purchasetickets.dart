// import 'package:flutter/material.dart';
// import 'package:eliel_client/models/ticketCategorie.dart';
// import 'package:eliel_client/provider/authProvider.dart';
// import 'package:provider/provider.dart';


// class PurchaseTicketPage extends StatefulWidget {
//   final List<TicketCategory> ticketCategories; // Les catégories de billets disponibles
//   final String? username ;
//   PurchaseTicketPage({required this.ticketCategories , required this.username});

//   @override
//   _PurchaseTicketPageState createState() => _PurchaseTicketPageState();
// }

// class _PurchaseTicketPageState extends State<PurchaseTicketPage> {
//   final _phoneNumberController = TextEditingController();
//   TicketCategory? _selectedCategory; // Catégorie de billet sélectionnée


//   @override
//   void initState() {
//     super.initState();
//     _selectedCategory = widget.ticketCategories.isNotEmpty
//         ? widget.ticketCategories[0]
//         : null; // Par défaut, sélectionnez la première catégorie de billet
//   }

//   @override
//   void dispose() {
//     _phoneNumberController.dispose();
//     super.dispose();
//   }

//   void _validateAndSubmit() {
//     // Valider le numéro de téléphone et la catégorie de billet sélectionnée
//     String phoneNumber = _phoneNumberController.text;
//     if (phoneNumber.length == 10 && _selectedCategory != null) {
//       // Envoyer les données (par exemple : passer à une nouvelle page ou envoyer une requête HTTP)
//       print('Numéro de téléphone: $phoneNumber');
//       print('Catégorie de billet: ${_selectedCategory!.categoryName}');
//       // Implémenter la logique pour envoyer ces informations
//     } else {
//       // Afficher un message d'erreur si les informations sont incorrectes
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Veuillez entrer un numéro valide et sélectionner un billet.')),
//       );
//     }
//   }



//   @override
//   Widget build(BuildContext context) {

//       // final username = auth.getUsername();
//       // print(username);
//   print (widget.username);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Achat de Ticket"),
//         backgroundColor: Colors.indigo,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Entrez votre numéro de téléphone à 10 chiffres :",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             TextField(
//               controller: _phoneNumberController,
//               keyboardType: TextInputType.phone,
//               maxLength: 10,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: "Numéro de téléphone",
//                 hintText: "Ex: 0707070707",
//               ),
//             ),
//             SizedBox(height: 20),
//             Text("Sélectionnez la catégorie de billet :",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             DropdownButton<TicketCategory>(
//               value: _selectedCategory,
//               isExpanded: true,
//               items: widget.ticketCategories.map((TicketCategory category) {
//                 return DropdownMenuItem<TicketCategory>(
//                   value: category,
//                   child: Text(category.categoryName),
//                 );
//               }).toList(),
//               onChanged: (TicketCategory? newValue) {
//                 setState(() {
//                   _selectedCategory = newValue;
//                 });
//               },
//             ),
//             Spacer(),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _validateAndSubmit,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   "Valider l'achat",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:eliel_client/models/ticketCategorie.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:uni_links/uni_links.dart';

import 'package:eliel_client/home/afterpayment.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart'; // Importez la bibliothèque intl
import 'package:eliel_client/home/eventpage/purchasetickets.dart';
import 'package:eliel_client/models/eventfuture.dart';
import 'package:eliel_client/models/ticketCategorie.dart'; // Importez votre modèle de catégorie de billets
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:eliel_client/util/constant.dart';


class PurchaseTicketPage extends StatefulWidget {
  final List<TicketCategory> ticketCategories;
  final String? username;
  final Event event;
  final String? tokenClient ;

  PurchaseTicketPage({required this.ticketCategories, required this.username , required this.event, required this.tokenClient});

  @override
  _PurchaseTicketPageState createState() => _PurchaseTicketPageState();
}

class _PurchaseTicketPageState extends State<PurchaseTicketPage> {
  final _phoneNumberController = TextEditingController();
  TicketCategory? _selectedCategory;
  String baseUrl = Constants.adresse;
  


  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.ticketCategories.isNotEmpty
        ? widget.ticketCategories[0]
        : null;
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }



//   Future<void> _handleDeepLink() async {
//   // Cette méthode écoutera les liens entrants
//   uriLinkStream.listen((Uri? uri) {
//     if (uri != null) {
//       // Analysez les paramètres de l'URL pour savoir si le paiement est réussi ou non
//       if (uri.queryParameters['status'] == 'success') {
//         // Redirigez l'utilisateur vers une page de succès
//         Navigator.pushReplacementNamed(context, '/success');
//       } else if (uri.queryParameters['status'] == 'failure') {
//         // Redirigez l'utilisateur vers une page d'échec
//         Navigator.pushReplacementNamed(context, '/failure');
//       }
//     }
//   });
// }

  Future<void> _validateAndSubmit() async {
    String phoneNumber = _phoneNumberController.text;
    if (phoneNumber.length == 10 ) {
      // Données à envoyer à l'API de paiement
      Map<String, dynamic> data = {
        "totalPrice":"200",
        "article": [
          {"vip1":"200"}
        ],
        "numeroSend": phoneNumber,
        "nomclient": widget.username ?? "Client",
        "return_url": "https://moneyfusion.net/dashboard/fusionstore"
      };

        // "return_url": "https://moneyfusion.net/dashboard/fusionstore"
        // http://192.168.109.151:8000/users/redirect-to-app/

      String apiUrl = 'https://www.pay.moneyfusion.net/TEST/77e693205c2d451d/pay/';
      try {
        // Effectuer la requête POST
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        // Traiter la réponse
        if (response.statusCode == 200 || response.statusCode == 201) {
          var jsonResponse = jsonDecode(response.body);
          print('Réponse du serveur : $jsonResponse');
          // Vous pouvez également rediriger l'utilisateur ou afficher une notification
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Paiement validé avec succès!')),
          );
          if (jsonResponse['statut'] == true && jsonResponse['url'] != null) {
              String paymentUrl = jsonResponse['url'];
              String token = jsonResponse['token'] ;
              print('URL de paiement : $paymentUrl');


              final Uri _url = Uri.parse(paymentUrl);

              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
              print(paymentUrl) ;
              print(token) ;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Afterpayment( token : token , event : widget.event , nameCategorie : "vip1", priceCategorie : "200", tokenClient:widget.tokenClient),
                ),
              );
             

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Redirection vers la page de confirmation de paiement...')),
              );
            
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erreur: ${jsonResponse['message']}')),
              );
            }

        } else {
          print('Erreur: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors du paiement')),
          );
        }
      } catch (e) {
        print('Exception grave: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Une erreur est survenue')),
        );
      }
    } else {
      // Afficher un message d'erreur si les informations sont incorrectes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez entrer un numéro valide et sélectionner un billet.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("voici  ticket la hoo:${widget.ticketCategories}"); // Vérifie que la liste contient des catégories
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:const Color.fromARGB(255, 28, 37, 136) ,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                        ),
                      ),
                    ),
                    Container(
                      child: Text("Achat du ticket" ,
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold , fontStyle: FontStyle.italic),

                      ),
                    ) ,
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.more_vert, color: Colors.white, size: 30),
                        ),
                      ),
                    ),
          
                  ],
                ),
              ) ,
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Entrez votre numéro monile money " , style: TextStyle( color: Colors.white),) , 
                  SizedBox(height: 15,),
                 TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  style: TextStyle(color: Colors.white),  // Couleur du texte tapé
                  decoration: InputDecoration(
                    counterText: '',  // Cache le compteur des caractères (si tu ne le veux pas)
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),  // Bordure arrondie (optionnel)
                      borderSide: BorderSide(
                        color: Colors.white,  // Couleur de la bordure par défaut (blanche)
                        width: 1.0,  // Épaisseur de la bordure (fine)
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),  // Bordure arrondie
                      borderSide: BorderSide(
                        color: Colors.white,  // Bordure blanche lorsque le champ est inactif
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.white,  // Bordure blanche même au focus
                        width: 1.0,
                      ),
                    ),
                    hintText: "Ex: 0707070707",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),  // Couleur blanche pour le hintText (avec opacité optionnelle)
                    ),
                  ),
                ),

                 
                ],
              ),
            ) ,
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text("Sélectionnez la catégorie de billet :" , style: TextStyle( color: Colors.white),) , 
                  
                   DropdownButton<TicketCategory>(
                    
                    value: _selectedCategory,
                    isExpanded: true,
                    items: widget.ticketCategories.map((TicketCategory category) {
                      return DropdownMenuItem<TicketCategory>(
                        value: category,
                        child: Text(
                          category.categoryName , 
                           style: TextStyle(
                              color: Colors.white, // Couleur du texte dans le menu
                              fontSize: 12,  
                              fontWeight: FontWeight.bold// Taille du texte
                            ),
                          ),
                      );
                    }).toList(),
                    onChanged: (TicketCategory? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                     dropdownColor: Colors.grey.withOpacity(0.4), // Couleur de fond du menu déroulant

                      icon: Icon(
                        Icons.arrow_drop_down, // Icone du menu
                        color: Colors.white,  // Couleur de l'icône
                      ),
                      underline: Container(
                        height: 1,
                        color:  Colors.grey.withOpacity(0.4),  // Couleur de la ligne sous le menu
                      ),
                      style: TextStyle(
                        color: Colors.white,  // Couleur du texte sélectionné
                        fontSize: 16,  // Taille du texte sélectionné
                      ),
                  ),
              ],
            ),
          ),
           
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _validateAndSubmit,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Valider l'achat",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
