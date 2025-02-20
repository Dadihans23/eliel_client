import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eliel_client/models/ticket.dart';
import 'package:eliel_client/service/get_ticket_service.dart';
import 'package:qr_flutter/qr_flutter.dart';



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

class TicketsPage extends StatefulWidget {
  final String? tokenClient;

  TicketsPage({required this.tokenClient});

  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  late Future<List<Ticket>> futureTickets;

  @override
  void initState() {
    super.initState();
    if (widget.tokenClient != null) {
      futureTickets = fetchTickets(widget.tokenClient!);
    } else {
      throw Exception('Token non disponible');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Mes tickets",
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Ticket>>(
        future: futureTickets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun ticket trouvé'));
          } else {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Ticket ticket = snapshot.data![index];
                print('Ticket ID: ${ticket.id}');
                 DateTime eventDate = DateTime.parse(ticket.event.date);
    
                String day = DateFormat('dd', 'fr_FR').format(eventDate);
                String month = DateFormat('MMMM', 'fr_FR').format(eventDate);
                String hour = DateFormat('HH', 'fr_FR').format(eventDate);
                String weekday = DateFormat('EEEE', 'fr_FR').format(eventDate); // Récupérez le jour de la semaine en français
                String year = DateFormat('yyyy', 'fr_FR').format(eventDate); // Récupérez l'année


                

                return Padding(
                  padding: EdgeInsets.all(08),
                  child: GestureDetector(
                    onTap: () {
                      // Lorsque l'utilisateur clique sur un ticket
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // pour rendre le modal plus grand
                        builder: (context) {
                          return TweenAnimationBuilder<double>(
                            
                            duration: Duration(milliseconds:1), // Durée de 3 secondes pour l'animation
                            curve: Curves.easeOut, // Courbe d'animation
                            tween: Tween(begin: 0.0, end: 0.8), // Animation entre 0 et 80% de l'écran
                            builder: (context, value, child) {
                              return FractionallySizedBox(
                                
                                heightFactor: value, // Ajustement de la hauteur animée
                                    
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25) , topRight: Radius.circular(25)),
                                        color: const Color.fromARGB(255, 28, 37, 136).withOpacity(0.9) 

                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Ticket',
                                              style: TextStyle(
                                                fontSize: 20 ,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                letterSpacing:-1 ,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                         
                                           Container(
                                           
                                             child: Center(
                                              child: QrImageView(
                                                data: 'ticket_id:${ticket.id}',
                                                version: QrVersions.auto,
                                                size: 250.0, // Taille du QR code
                                                backgroundColor: Colors.white,
                                                padding: EdgeInsets.all(16),
                                              ),
                                                                                     ),
                                           ),
                                           Column(
                                            children: [
                                              Text(
                                                    ticket.event.name,
                                                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),  
                                                ),
                                              
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 05),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                      " Creer par ${ticket.event.organizerName}",
                                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w300 , fontStyle: FontStyle.italic),  
                                                  ),
                                                                        
                                                ],
                                              ),
                                              
                                            ) ,
                                          Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 05 , vertical: 07),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.grey.withOpacity(0.3),
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: 15 , vertical:10),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children:[
                                                          Icon(Icons.category, color: Colors.white, size: 20) ,
                                                          SizedBox(width: 03,) ,
                                                          Flexible(child: Text('Categorie : ${ticket.categoryName}', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600 , letterSpacing: 02.0  ,fontStyle: FontStyle.italic , ),)) ,
                                                      ]
                                                    ), 
                                                    SizedBox(height:05) ,
                                                    Row(
                                                      children:[
                                                          Icon(Icons.money, color: Colors.white, size: 20) ,
                                                          SizedBox(width: 10,) ,
                                                          Text('Prix : ${ticket.price.toString()} FCFA',  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600 ,  letterSpacing: 02.0  ,fontStyle: FontStyle.italic ),) ,
                                                      ]
                                                    ) ,
                                                    
                                                  ],
                                                )
                                                
                                              ),
                                            ) ,
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 05 , vertical: 07),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.grey.withOpacity(0.3),
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: 15 , vertical:10),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    
                                                    Row(
                                                      children:[
                                                          Icon(Icons.place, color: Colors.white, size: 20) ,
                                                          SizedBox(width: 03,) ,
                                                          Flexible(child: Text( "${ticket.event.locationPlace},${ticket.event.locationCommune}" , style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600 , letterSpacing: 02.0  ,fontStyle: FontStyle.italic , ),)) ,
                                                      ]
                                                    ), 
                                                    SizedBox(height:05) ,
                                                    Row(
                                                      children:[
                                                          Icon(Icons.alarm, color: Colors.white, size: 20) ,
                                                          SizedBox(width: 10,) ,
                                                          Text( "${ticket.event.startTime} -- ${ticket.event.endTime}" , style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600 ,  letterSpacing: 02.0  ,fontStyle: FontStyle.italic ),) ,
                                                      ]
                                                    ) ,
                                                    SizedBox(height:05) ,
                                                    Row(
                                                      children: [
                                                        Icon(Icons.date_range, color: Colors.white, size: 20) ,
                                                        SizedBox(width: 5),
                                                        Text(weekday, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600 , letterSpacing: 02.0  ,fontStyle: FontStyle.italic )),
                                                        SizedBox(width: 5),
                                                        Text(day, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600 , letterSpacing: 02.0  ,fontStyle: FontStyle.italic )),
                                                        SizedBox(width: 5),
                                                        Text(month, style: TextStyle(color: Colors.white,fontSize: 12, fontWeight: FontWeight.w600 ,  letterSpacing: 02.0  ,fontStyle: FontStyle.italic )),
                                                      ],
                                                    ) ,
                                                  ],
                                                )
                                                
                                              ),
                                            ) ,
                                            ],
                                           )
                                          
                                        ],
                                      ),
                                    ),
                                 
                             
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(08),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Row(
                        children: [
                          QrImageView(
                            data: 'ticket_id:${ticket.id}',
                            version: QrVersions.auto,
                            size: 100.0,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Evenement : ${ticket.event.name}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: -1.00,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                'Categorie : ${ticket.categoryName}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: -1.00,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                'Prix : ${ticket.price.toString()} FCFA',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: -1.00,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
