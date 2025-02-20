import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eliel_client/components/custominput.dart';
import 'package:http/http.dart' as http;
import 'package:eliel_client/home/eventpage/eventdetails.dart';
import 'package:eliel_client/provider/authProvider.dart';
import 'package:eliel_client/provider/favorisProvider.dart';
import 'package:provider/provider.dart';
import 'package:eliel_client/models/eventfuture.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:intl/intl.dart'; // Importez la bibliothèque intl
import 'package:intl/date_symbol_data_local.dart'; // Importez les données de symboles de date locales
// import 'package:flutter_vibrate/flutter_vibrate.dart';

import 'package:eliel_client/util/constant.dart';


class Decouvrir extends StatefulWidget {

  final String? tokenClient;
    final List<Event> favoritesEvent; // Ajoutez cette propriété
      final FavoritesProvider favoritesProvider; // Ajouter cette ligne
      final String? username; // Ajouter cette ligne


  const Decouvrir({Key? key, this.tokenClient , required this.favoritesEvent ,  required this.favoritesProvider,required this.username}) : super(key: key);

  @override
  State<Decouvrir> createState() => _DecouvrirState();
}

class _DecouvrirState extends State<Decouvrir> {
  String baseUrl = Constants.adresse;

  bool isNotificationEnabled = true;

  void toggleNotification() async {
    setState(() {
      isNotificationEnabled = !isNotificationEnabled;
    });
  }



  bool _isLocaleInitialized = false;

  @override
  void initState() {
    super.initState();

    // Initialisation du formatage de la date
    initializeDateFormatting('fr_FR', null).then((_) {
      setState(() {
        _isLocaleInitialized = true; // Marquer l'initialisation comme terminée
      });
    });
  }




  @override
  Widget build(BuildContext context) {


// final organisateur = Provider.of<Organisateur>(context);
    // final FavorisProvider = Provider.of<FavoritesProvider>(context);

    String? tokenClient = widget.tokenClient;
    String? username = widget.username;
    String? token = "c7a4964198cb1bb5d176aa00b80e33c516281c03";
    String adresse = baseUrl; 

     Future<List<Event>> fetchEvents(String token) async {
      final response = await http.get(
        Uri.parse('http://$adresse:8000/users/all_event/upcoming/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
      );
      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes); // Décode en UTF-8
        List<dynamic> jsonResponse = json.decode(responseBody);
        return jsonResponse.map((event) => Event.fromJson(event)).toList();
      } else {
        throw Exception('Failed to load events');
      }
    }



    Future<void> toggleFavorite(Event event) async {

        // Corps de la requête (payload)
        Map<String, dynamic> requestData = {
          "tokenClient": tokenClient,
          "event_id": event.id,
        };

    final response = await http.post(
      Uri.parse('http://$adresse:8000/users/api/favorite-event/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),

    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print( event.isFavorite ) ;
      setState(() {
        event.isFavorite = !event.isFavorite; // Bascule l'état du favori
      });
      print(' ok ') ;
      print( event.isFavorite ) ;
    }
     else {
      // Gérer les erreurs de réponse
      print(response.statusCode);
    }
  }



  void navigateToEventDetails(BuildContext context, Event event) {
  Future.delayed(Duration(milliseconds: 10), () { // Délai de 500 ms
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1800),
        pageBuilder: (context, animation, secondaryAnimation) => EventDetailsPage(event: event , username : username , tokenClient : tokenClient),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(5.0, 5.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  });
}  
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 08),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child :Text("ABIDJAN" ,) ,
                      ) ,  
                      GestureDetector(
                        onTap: toggleNotification,
                        child: Container(
                          child: Icon(
                            isNotificationEnabled ? Icons.notifications : Icons.notifications_off, size: 35
                          ),
                        ),
                      )
                    ],
                  ),
                ) ,
                Container(
                
                  child: TextField(
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                      prefixIcon: Icon(Icons.search)
                    ),
                    controller: TextEditingController(),
                  ),
                ) ,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child :Text("Recement publié" , style: TextStyle( color: Colors.black , fontWeight: FontWeight.w600 , fontSize: 16 , letterSpacing: -1.00 , fontStyle: FontStyle.italic)) ,
                      ) ,  
                      Container(
                        child :Text("" ,) ,
                      )
                    ],
                  ),
                ) ,
                 
                Container(
                    height: MediaQuery.of(context).size.height*0.40 ,
                    width: MediaQuery.of(context).size.width*1,
                    child:  FutureBuilder<List<Event>>(
                       future: fetchEvents(token),
                      builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text(" PAS ENCORE D'EVENEMENT "));
                    } else {
                      List<Event> events = snapshot.data!;
            
                        // Trier les événements par date de création
                      events.sort((a, b) => DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));
                  
                     // Obtenir les trois événements les plus récents
                     List<Event> recentEvents = events.take(3).toList();
            
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: recentEvents.length,
                        itemBuilder: (context, index) {
                          Event event = recentEvents[index];
                          DateTime eventDateCreation = DateTime.parse(event.createdAt); // Parsez la date de l'événement
            
                          DateTime eventDate = DateTime.parse(event.date); // Parsez la date de l'événement
                          String day = DateFormat('dd', 'fr_FR').format(eventDate); // Récupérez le jour
                          String month = DateFormat('MMMM', 'fr_FR').format(eventDate); // Récupérez le mois en français
                          String weekday = DateFormat('EEEE', 'fr_FR').format(eventDate); // Récupérez le jour de la semaine en français
                          print(event.ticketTypes) ;
                          return GestureDetector(
                              onTap: () {
                                navigateToEventDetails(context, event );
                              },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey[300],
            
                                    ),
                                    height: MediaQuery.of(context).size.height * 1,  // Ajuste la hauteur ici
                                    width: MediaQuery.of(context).size.width * 0.65, // Change the height to width for horizontal
                                    child: Column(
                                      children: [
                                      
                                         Container(
                                              height: MediaQuery.of(context).size.height * 0.2,  // Ajuste la hauteur ici
                                              width: MediaQuery.of(context).size.width * 0.65,  
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
                                            child : Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10) ,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:[
                                                            Text(event.name , style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w800),) ,
                                                            Row(
                                                              children: [
                                                                 Icon(Icons.place, color: Colors.black, size: 12) ,
                                                                 Text(event.locationPlace , style: TextStyle(color: Colors.black, fontSize: 07, fontWeight: FontWeight.w600),) ,
                                                                 Text( ",${event.locationCommune}" , style: TextStyle(color: Colors.black, fontSize: 07, fontWeight: FontWeight.w600),) ,
            
            
            
                                                              ],
                                                            ) 
                                                    ]
                                                  ),
                                                ) ,
                                                 
                              
                                              ],
                                            )
                                          ) ,
                                          Container(
                                            child : Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
            
                                                Row(
                                                  children: [
                                                    Icon(Icons.date_range, color: Colors.black, size: 12) ,
                                                    SizedBox(width: 3),
                                                    Text(weekday, style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500 , fontStyle: FontStyle.italic)),
                                                    SizedBox(width: 3),
                                                    Text(day, style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500 ,fontStyle: FontStyle.italic)),
                                                    SizedBox(width: 3),
                                                    Text(month, style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500 , fontStyle: FontStyle.italic)),
                                                  ],
                                                ) ,
                                                
                                                GestureDetector(
                                                    onTap: () => {
                                                      // toggleFavorite(event) ,   
                                                      widget.favoritesProvider.toggleFavorite(event)  ,
                                                      setState(() {
                                                        print(widget.favoritesEvent.length);
                                                      })                        
                                                     },
                                                    child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.withOpacity(0.3),
                                                      borderRadius: BorderRadius.circular(100),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(6.0),
                                                      child: Icon(
                                                          Icons.favorite ,
                                                          color: widget.favoritesProvider.isFavorite(event) ? Colors.red : Colors.white, // Change la couleur en fonction de l'état
                                                          size: 20,),
                                                    ),
                                                  ),
                                                ),
                                                 
            
                                              ],
                                            )
                                          ) , 
                                          Container(
                                                  padding: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                   color: const Color.fromARGB(255, 28, 37, 136) ,
                                                   borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: Column(
                                                    children:[
                                                    //  Text("gratuit" ,
                                                    //     // event.ticketTypes.isEmpty 
                                                    //     //     ? 'Gratuit' 
                                                    //     //     : event.ticketTypes.map((ticket) => ticket.price).join(', '), // Affiche le prix des tickets
                                                    //     style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                                    //   ),
            
                                                    ]
                                                  ),
                                                )
                                      ],
                                    ),
                                   
                                  ) ,
            
                              ),
                          );
                        },
                      );
                    }
                                },
                    ),
                    
                  ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child :Text("Touts les évenements" , style: TextStyle( color: Colors.black , fontWeight: FontWeight.w600 , fontSize: 16 , letterSpacing: -1.00 , fontStyle: FontStyle.italic)) ,
                      ) ,  
                      Container(
                        child :Text("" ,) ,
                      )
                    ],
                  ),
                ) ,
               
                 
                Container(
                    height: MediaQuery.of(context).size.height*0.40 ,
                    width: MediaQuery.of(context).size.width*1,
                    child:  FutureBuilder<List<Event>>(
                       future: fetchEvents(token),
                      builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text(" PAS ENCORE D'EVENEMENT "));
                    } else {
                      List<Event> events = snapshot.data!;
            
                        // Trier les événements par date de création
                      events.sort((a, b) => DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));
                  
                     // Obtenir les trois événements les plus récents
                     List<Event> recentEvents = events.take(3).toList();
            
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          Event event = events[index];
                          DateTime eventDateCreation = DateTime.parse(event.createdAt); // Parsez la date de l'événement
            
                          DateTime eventDate = DateTime.parse(event.date); // Parsez la date de l'événement
                          String day = DateFormat('dd', 'fr_FR').format(eventDate); // Récupérez le jour
                          String month = DateFormat('MMMM', 'fr_FR').format(eventDate); // Récupérez le mois en français
                          String weekday = DateFormat('EEEE', 'fr_FR').format(eventDate); // Récupérez le jour de la semaine en français
                          print(event.ticketTypes) ;
                          return GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                              child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey[300],
                                      ),
                                      height: 150,  // Ajuste la hauteur ici
                                      width: MediaQuery.of(context).size.width * 0.65, // Change the height to width for horizontal
                                      child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 5),
                                              height: MediaQuery.of(context).size.height * 0.2,  // Ajuste la hauteur ici
                                              width: MediaQuery.of(context).size.width * 0.35,  
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
                                            SizedBox(width: 8), 
                                            Expanded(  // Utilise Expanded ici pour ajuster l'espace
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      event.name,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,  // Empêche le texte de déborder
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.date_range, color: Colors.black, size: 18),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          weekday,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w500,
                                                            fontStyle: FontStyle.italic,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          day,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w500,
                                                            fontStyle: FontStyle.italic,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          month,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w500,
                                                            fontStyle: FontStyle.italic,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.place, color: Colors.black, size: 18),
                                                        Expanded(
                                                          child: Text(
                                                            event.locationPlace,
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,  // Empêche le texte de déborder
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "${event.locationCommune}",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,  // Empêche le texte de déborder
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20),
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(Icons.visibility,
                                                                color: const Color.fromARGB(255, 28, 37, 136),
                                                                size: 25),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              '${event.views}',
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 10,
                                                                fontWeight: FontWeight.w600,
                                                                fontStyle: FontStyle.italic,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),  // Ajoute un espace flexible
                                                        GestureDetector(
                                                          onTap: () {
                                                            widget.favoritesProvider.toggleFavorite(event);
                                                            setState(() {
                                                              print(widget.favoritesEvent.length);
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey.withOpacity(0.3),
                                                              borderRadius: BorderRadius.circular(100),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(6.0),
                                                              child: Icon(
                                                                Icons.favorite,
                                                                color: widget.favoritesProvider.isFavorite(event)
                                                                    ? Colors.red
                                                                    : Colors.white, // Change la couleur en fonction de l'état
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
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
                    
                  ),
                
               
              ],
            ),
          ),
        ),
      ),
    );
  }


}


























