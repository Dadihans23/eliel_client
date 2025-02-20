// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
// import 'package:eliel_client/models/eventfuture.dart';


// class Afterpayment extends StatefulWidget {
//   final Event event ;
//   final String token;
//   final  String nameCategorie ;
//   final  String priceCategorie ;


//   const Afterpayment({super.key, required this.token , required this.event , required this.nameCategorie, required this.priceCategorie});

//   @override
//   State<Afterpayment> createState() => _AfterpaymentState();
// }

// class _AfterpaymentState extends State<Afterpayment> {
//   Map<String, dynamic>? paymentData; // Pour stocker les détails du paiement
//   bool isLoading = true; // Indicateur de chargement
//   bool showError = false; // Indicateur d'échec de paiement

//   @override
//   void initState() {
//     super.initState();
//     // Lancer le temporisateur de 1 minute et 30 secondes avant d'appeler l'API
//     Future.delayed(Duration( seconds: 70), () {
//       _getPaymentStatus();
//     });
//   }

//   Future<void> _getPaymentStatus() async {
//     final url = 'https://www.pay.moneyfusion.net/paiementNotif/${widget.token}';

//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final jsonResponse = jsonDecode(response.body);
//         if (jsonResponse['statut'] == true) {
//           setState(() {
//             paymentData = jsonResponse['data']; // Récupérer les données de l'API
//             isLoading = false;
//             if (paymentData!['statut'] == "pending" || paymentData!['statut'] == "failure" || paymentData!['statut'] == "no paid") {
//               showError = true; // Si le paiement a échoué ou est en attente
//             }
//             else{
//               _sendTicketCreationRequest();
//             }
//           });
//         } else {
//           setState(() {
//             isLoading = false;
//             showError = true;
//           });
//         }
//       } else {
//         setState(() {
//           isLoading = false;
//           showError = true;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         showError = true;
//       });
//     }
//   }


//   Future<void> _sendTicketCreationRequest() async {
//     final url = 'http://192.168.3.151:8000/users/api/create-ticket/';

//     // Préparer les données du ticket à envoyer à l'API
//     final Map<String, dynamic> ticketData = {
//       'token': widget.token, // Utiliser le token du client pour l'authentification
//       'event_id': widget.event.id, // Utiliser un event_id valide récupéré selon ton contexte
//       'category_name': widget.nameCategorie, // Exemple de catégorie, modifier selon le besoin
//       'price': widget.priceCategorie, // Prix à utiliser (doit être récupéré dynamiquement si possible)
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(ticketData),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final jsonResponse = jsonDecode(response.body);
//         print('Ticket créé avec succès : ${jsonResponse['ticket_id']}');
//         // Afficher une confirmation de création de ticket
//         _showSuccessDialog(jsonResponse);
//       } else {
//         print('Erreur lors de la création du ticket: ${response.body}');
//         _showErrorDialog('Erreur lors de la création du ticket.');
//       }
//     } catch (e) {
//       print('Erreur réseau : $e');
//       _showErrorDialog('Impossible de contacter le serveur.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: Text("Statut du paiement")),

//       body: isLoading
//           ? Center(child: CircularProgressIndicator()) // Chargement en cours pendant 1 min 30s
//           : showError // Si erreur ou paiement en attente ou échoué
//               ? Container( 
//                 padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
//                 child: Column(
//                   children:[
//                                  Container(
//                 margin: EdgeInsets.symmetric(vertical: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: (){
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(0.3),
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
//                         ),
//                       ),
//                     ),
                    
//                   ],
//                 ),
//               ) ,
//                     Container(
//                       height: MediaQuery.of(context).size.height*0.8,
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset("lib/images/paymentfailed.png", width: 200, height: 150,),
//                             SizedBox(height: 10),
//                             Text(
//                               "Paiement échoué , veuillez retourner",
//                               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black , fontStyle: FontStyle.italic , letterSpacing: -0.5),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ] 
//                 ),
//               )
//               : Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                       'bravooo'
//                       ),
                     
//                     ],
//                   ),
//                 ),
//     );
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eliel_client/models/eventfuture.dart';
import 'package:eliel_client/util/constant.dart';

import 'package:eliel_client/util/constant.dart';

class Afterpayment extends StatefulWidget {
  final Event event;
  final String token;
  final String nameCategorie;
  final String priceCategorie;
  final String? tokenClient ;

  const Afterpayment({
    Key? key,
    required this.token,
    required this.event,
    required this.nameCategorie,
    required this.priceCategorie,
    required this.tokenClient,
  }) : super(key: key);

  @override
  State<Afterpayment> createState() => _AfterpaymentState();
}

class _AfterpaymentState extends State<Afterpayment> {
  Map<String, dynamic>? paymentData;
  bool isLoading = true;
  bool showError = false;
  String baseUrl = Constants.adresse;




  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 60), () {
      _getPaymentStatus();
    });
  }

  Future<void> _getPaymentStatus() async {
    final url = 'https://www.pay.moneyfusion.net/paiementNotif/${widget.token}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['statut'] == true) {
          setState(() {
            paymentData = jsonResponse['data'];
            isLoading = false;
            if (paymentData!['statut'] == "pending" ||
                paymentData!['statut'] == "failure" ||
                paymentData!['statut'] == "no paid") {
              showError = true;
            } else {
              _sendTicketCreationRequest();
            }
          });
        } else {
          setState(() {
            isLoading = false;
            showError = true;
          });
        }
      } else {
        setState(() {
          isLoading = false;
          showError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        showError = true;
      });
    }
  }

  Future<void> _sendTicketCreationRequest() async {
    final url = 'http://${baseUrl}:8000/users/api/create-ticket/';

    final Map<String, dynamic> ticketData = {
      'token': widget.tokenClient,
      'event_id': widget.event.id,
      'category_name': "vip1",
      'price': "200",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(ticketData),
      );
      print(widget.tokenClient);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        print('Ticket créé avec succès : ${jsonResponse['ticket_id']}');
      } else {
        print('Erreur lors de la création du ticket: ${response.body}');
        _showErrorDialog('Erreur lors de la création du ticket.');
      }
    } catch (e) {
      print('Erreur réseau : $e');
      _showErrorDialog('Impossible de contacter le serveur.');
    }
  }

  // void _showSuccessDialog(Map<String, dynamic> jsonResponse) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Succès'),
  //       content: Text('Votre ticket a été créé avec succès : ${jsonResponse['ticket_id']}'),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erreur'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : showError
              ? _buildErrorContent()
              : _buildSuccessContent(),
    );
  }

  Widget _buildErrorContent() {
    return 
    Container( 
                padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
                child: Column(
                  children:[
                                 Container(
                margin: EdgeInsets.symmetric(vertical: 5),
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
                          child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ) ,
                    Container(
                      height: MediaQuery.of(context).size.height*0.8,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("lib/images/paymentfailedremove.png", width: 200, height: 150,),
                            SizedBox(height: 10),
                            Text(
                              "Paiement échoué , veuillez retourner",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black , fontStyle: FontStyle.italic , letterSpacing: -0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] 
                ),
              ) ;
  }

  Widget _buildSuccessContent() {
    return 
    Container( 
      padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
      child: Column(
        children:[
    Container(
      margin: EdgeInsets.symmetric(vertical: 5),
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
                child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
              ),
            ),
          ),
          
        ],
      ),
    ) ,
          Container(
            height: MediaQuery.of(context).size.height*0.8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check, color: Colors.green , size: 100,) ,
                  SizedBox(height: 10),
                  Text(
                    "Paiement validé , veuillez retourner",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black , fontStyle: FontStyle.italic , letterSpacing: -0.5),
                  ),
                ],
              ),
            ),
          ),
        ] 
      ),
    ) ;
  }
}

