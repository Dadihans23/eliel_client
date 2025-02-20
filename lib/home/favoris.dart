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
import 'package:intl/intl.dart'; 
import 'package:intl/date_symbol_data_local.dart'; 
// import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:eliel_client/util/constant.dart';


class FavorisPage extends StatefulWidget {
  final String? username;
  final String? tokenClient;

  const FavorisPage({Key? key, required this.username, required this.tokenClient}) : super(key: key);

  @override
  _FavorisPageState createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
    String baseUrl = Constants.adresse;


  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    String adresse = baseUrl;

    void navigateToEventDetails(BuildContext context, Event event) {
      Future.delayed(Duration(milliseconds: 10), () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1800),
            pageBuilder: (context, animation, secondaryAnimation) =>
                EventDetailsPage(event: event, username: widget.username, tokenClient: widget.tokenClient),
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
      appBar: AppBar(
        title: Center(
          child: Text(
            "Mes evenement favoris",
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      body: favoritesProvider.favoriteEvents.isEmpty
          ? Center(
              child: Text("Aucun événement favori ajouté."),
            )
          : ListView.builder(
              itemCount: favoritesProvider.favoriteEvents.length,
              itemBuilder: (context, index) {
                final event = favoritesProvider.favoriteEvents[index];
                DateTime eventDate = DateTime.parse(event.date);
                String day = DateFormat('dd', 'fr_FR').format(eventDate);
                String month = DateFormat('MMMM', 'fr_FR').format(eventDate);
                String weekday = DateFormat('EEEE', 'fr_FR').format(eventDate);

                return GestureDetector(
                  onTap: () {
                    navigateToEventDetails(context, event);
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    color: Colors.grey.withOpacity(0.2),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.20,
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
                        Expanded(
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
                                overflow: TextOverflow.ellipsis,
                              ),
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
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            favoritesProvider.clearFavorites(event);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
