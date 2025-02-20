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


class EventDetailsPage extends StatefulWidget {
  final String? tokenClient ;
  final Event event;
  final String? username ;

  EventDetailsPage({required this.event , required this.username , required this.tokenClient});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late Future<List<TicketCategory>> ticketCategories;
  bool isLoading = true; // État de chargement

  String baseUrl = Constants.adresse;


  @override
  void initState() {
    super.initState();
    // Initialiser le chargement des catégories de billets
  

    ticketCategories = fetchTicketCategories(widget.event.id); // Assurez-vous que `event.id` est bien défini
  }

//   Future<List<TicketCategory>> fetchTicketCategories(int eventId) async {
//   final response = await http.post(
//     Uri.parse('http://${baseUrl}:8000/users/get-ticket-categories/'),
//     headers: {"Content-Type": "application/json"},
//     body: json.encode({"event_id": eventId}), // Envoyer l'ID d'événement dans le corps de la requête
//   );

//   if (response.statusCode == 200) {
//     List<dynamic> jsonResponse = json.decode(response.body);
//     print('tiket ici ') ;
//     print(eventId) ;
//     print(jsonResponse) ;
//     return jsonResponse.map((category) => TicketCategory.fromJson(category)).toList();
//   } else {
//     throw Exception('Failed to load ticket categories');
//   }
// }

Future<List<TicketCategory>> fetchTicketCategories(int eventId) async {
  final response = await http.post(
    Uri.parse('http://${baseUrl}:8000/users/api/tickets/get_by_event/'), // Mets l'URL de ton API
    headers: {"Content-Type": "application/json"},
    body: json.encode({"event_id": eventId}),
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    print('Tickets récupérés avec succès :');
    print(jsonResponse);

    return jsonResponse
        .map((ticket) => TicketCategory.fromJson(ticket))
        .toList();
  } else {
    throw Exception('Échec du chargement des tickets');
  }
}


  @override
  Widget build(BuildContext context) {


    String adresse = baseUrl; 
    double screenWidth = MediaQuery.of(context).size.width;

    // Définissez la taille de la police en fonction de la largeur de l'écran
    double fontSize = screenWidth * 0.06;
    final event = widget.event ;   
    DateTime eventDate = DateTime.parse(widget.event.date);
    
    String day = DateFormat('dd', 'fr_FR').format(eventDate);
    String month = DateFormat('MMMM', 'fr_FR').format(eventDate);
    String hour = DateFormat('HH', 'fr_FR').format(eventDate);
    String weekday = DateFormat('EEEE', 'fr_FR').format(eventDate); // Récupérez le jour de la semaine en français
    String year = DateFormat('yyyy', 'fr_FR').format(eventDate); // Récupérez l'année
    print("image");
    print(" voici l'image ${event.image}" ); 
    print (widget.username);


    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 28, 37, 136) ,
      body: SafeArea(
        child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 08 , vertical:20 ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
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
                      child: Text("Details de l'evenement" ,
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
                height: MediaQuery.of(context).size.height * 0.40,
                 decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    image: event.image != null
                        ? DecorationImage(
                            image: NetworkImage("http://$adresse:8000${event.image!}"),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: AssetImage("lib/images/didib.jpg"),
                            fit: BoxFit.cover,
                          ),
                  ),
              ),   
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        event.name,
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),  
                    ),
                    //   Text(
                    //     "20.876  FCFA",
                    //     style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),  
                    // ),                      
                  ],
                ),
                
              ) ,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        " Creer par ${event.organizerName}",
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w300 , fontStyle: FontStyle.italic),  
                    ),
                                          
                  ],
                ),
                
              ) ,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20 , vertical:25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Row(
                        children:[
                            Icon(Icons.place, color: Colors.white, size: 20) ,
                            SizedBox(width: 03,) ,
                            Flexible(child: Text( "${event.locationPlace},${event.locationCommune}" , style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600 , letterSpacing: 02.0  ,fontStyle: FontStyle.italic , ),)) ,
                        ]
                      ), 
                      SizedBox(height:10) ,
                      Row(
                        children:[
                            Icon(Icons.alarm, color: Colors.white, size: 20) ,
                            SizedBox(width: 10,) ,
                            Text( "${event.startTime} -- ${event.endTime}" , style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600 ,  letterSpacing: 02.0  ,fontStyle: FontStyle.italic ),) ,
                        ]
                      ) ,
                      SizedBox(height:10) ,
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

                      SizedBox(height:15) ,
                      Row(
                        children:[
                            Icon(Icons.people, color: Colors.white, size: 20) ,
                            SizedBox(width: 03,) ,
                            Text( "${event.views == 0 ? 1 : event.views}",
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600 , letterSpacing: 02.0  ,fontStyle: FontStyle.italic ),) ,
                        ]
                      ), 
                    ],
                  )
                  
                ),
              ) ,

              FutureBuilder<List<TicketCategory>>(
                future: fetchTicketCategories(event.id), // Utilisez l'ID de l'événement pour récupérer les catégories
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Affiche un indicateur de chargement
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else {
                    List<TicketCategory> categories = snapshot.data!;

                    return Column(
                      children: [
                        Column(
                        children: categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal:20, vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    category.categoryName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2.0,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    "${category.price} FCFA",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 08),
                child: GestureDetector(
                  onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PurchaseTicketPage(ticketCategories: categories , username : widget.username , event : event , tokenClient: widget.tokenClient),
                        ),
                      );
                  } ,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85, // Change the height to width for horizontal
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.indigo.shade600 ,
                       boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // Couleur de l'ombre
                          spreadRadius: 2, // Rayon de propagation de l'ombre
                          blurRadius: 10, // Rayon de flou de l'ombre
                          offset: Offset(1, 5), // Décalage de l'ombre (x, y)
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20 , vertical:20),
                    child: Text(" Acheter un ticket"  ,  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold , letterSpacing: 02.0  ,fontStyle: FontStyle.italic ) , textAlign: TextAlign.center,),
                               
                  ),
                ),
              ) ,

                      ],
                    );
                  }
                },
              ),
               



                  
            ],
          ),
        ),
      )
      )
    );
  }
}




// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart'; // Importez la bibliothèque intl
// import 'package:eliel_client/models/eventfuture.dart';


// import 'package:provider/provider.dart';

// class EventDetailsPage extends StatelessWidget {
//   final Event event;

//   EventDetailsPage({required this.event});

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     // Définissez la taille de la police en fonction de la largeur de l'écran
//     double fontSize = screenWidth * 0.06;


//     DateTime eventDate = DateTime.parse(event.date);
    
//     String day = DateFormat('dd', 'fr_FR').format(eventDate);
//     String month = DateFormat('MMMM', 'fr_FR').format(eventDate);
//     String hour = DateFormat('HH', 'fr_FR').format(eventDate);
//     String weekday = DateFormat('EEEE', 'fr_FR').format(eventDate); // Récupérez le jour de la semaine en français
//     String year = DateFormat('yyyy', 'fr_FR').format(eventDate); // Récupérez l'année
//     print("image");
//     print(" voici l'image ${event.image}" ); 

//     return Scaffold(
//       backgroundColor: Colors.indigo.shade100,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.50,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage("http://192.168.160.151:8000${event.image!}"), // Utilisez l'image de l'événement
//                         fit: BoxFit.cover,

//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 20,
//                     left: 15,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(0.3),
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 20,
//                     right: 15,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(Icons.share, color: Colors.white, size: 30),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.bottomRight,
//                     colors: [
//                       Colors.indigo,
//                       Colors.black.withOpacity(.9),
//                     ],
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Text(
//                               event.name,
//                               style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       " ${day} ${month} - ${event.locationPlace}",
//                                       style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(vertical: 20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 5),
//                                   child: Text('A propos', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 5),
//                                   child: Text(
//                                     event.description,
//                                     style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(vertical: 10),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       height: 50,
//                                       width: 50,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(100),
//                                         image: DecorationImage(
//                                           image: AssetImage("lib/images/salle.png") , 
//                                           fit: BoxFit.cover
//                                           ) ,
                                      
//                                       ),
//                                     ),
//                                     SizedBox(width: 12),
//                                     Container(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(event.locationPlace,
//                                               style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
//                                           Text(" ${event.locationCommune} , ${event.locationVille}",
//                                               style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 15),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       height: 50,
//                                       width: 50,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(100),
//                                          image: DecorationImage(
//                                           image: AssetImage("lib/images/hand.jpg") , 
//                                           fit: BoxFit.cover
//                                           ) ,
//                                       ),
//                                     ),
//                                     SizedBox(width: 12),
//                                     Container(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(" ${weekday} , ${day} ${month} , ${year}",
//                                               style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
//                                           Text(" ${event.startTime} - ${event.endTime}",
//                                               style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(vertical: 20),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Divider(thickness: 1, color: Colors.white),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                                   child: Row(
//                                     children: [
//                                       Text("Billetterie ",
//                                           style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold)),
//                                       Icon(Icons.payments, color: Colors.white),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Divider(thickness: 1, color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           event.ticketTypes.isEmpty
//                           ? Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 10),
//                               child: Center(
//                                 child: Container(
//                                   padding: EdgeInsets.all(20),
//                                   decoration: BoxDecoration(
//                                     borderRadius:  BorderRadius.circular(100),
//                                     color: Colors.white,
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                     "Entrée gratuit",
//                                     style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   Icon(Icons.payment_rounded , color: Colors.black,)
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             )
//                           : Container(
//                             padding: const EdgeInsets.symmetric(vertical: 20),
//                             child: Table(
//                               border: TableBorder(horizontalInside: BorderSide(color: Colors.white) , verticalInside: BorderSide(color: Colors.white)),
//                               columnWidths: {
//                                 0: FlexColumnWidth(1),
//                                 1: FlexColumnWidth(1),
//                                 2: FlexColumnWidth(1),
//                               },
//                               children: [
//                                 TableRow(
//                                   decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
//                                   children: [
//                                     TableCell(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text('Nom', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text('Prix', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text('Quantité', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 ...event.ticketTypes.map(
//                                   (ticketType) => TableRow(
//                                     children: [
//                                       TableCell(
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                                           child: Text(ticketType.name, style: TextStyle(color: Colors.white ,)  ,textAlign: TextAlign.center,),
//                                         ),
//                                       ),
//                                       TableCell(
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text('${ticketType.price} FCFA',  style: TextStyle(color: Colors.white ,)  ,textAlign: TextAlign.center,),
//                                         ),
//                                       ),
//                                       TableCell(
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text('${ticketType.quantityAvailable}',  style:TextStyle(color: Colors.white ,)  ,textAlign: TextAlign.center,),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ).toList(),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
