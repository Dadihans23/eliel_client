import 'package:eliel_client/models/ticket.dart';
import 'package:eliel_client/provider/ticketprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:eliel_client/home/reportingpage.dart';
import 'package:eliel_client/home/sugestion.dart';

import 'package:eliel_client/provider/authprovider.dart';
import 'package:provider/provider.dart';
import 'package:eliel_client/provider/favorisProvider.dart';
import 'package:eliel_client/provider/ticketprovider.dart';

import 'package:eliel_client/service/get_ticket_service.dart';




class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    late Future<List<Ticket>> futureTickets;


 @override
  void initState() {
    super.initState();
    
  }




  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    String? tokenClient = auth.getToken();
    
    final favoritesProvider = Provider.of<FavoritesProvider>(context) ;
    // final ticket = Provider.of<TicketProvider>(context) ;

    final counterFavorites = favoritesProvider.favoriteEvents.length ;
    // final counterTicket = ticket.AllTicket.length ;

    futureTickets = fetchTickets(tokenClient!);

    

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
        body: Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                      SizedBox(height: 25,) ,
                      Center(
                        child: Container(
                          child:  Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("lib/images/intro.png",)
                                ),
                              ),
                            ), 
                        ),
                        
                      ) ,
                      Text("Hans Dadi" , style: TextStyle( color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),)
                      ,              
                      SizedBox(height: 12,) ,
                      Text("Dadihans06@gmail.com" ,style: TextStyle( color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 13 , letterSpacing: 3 , fontStyle: FontStyle.italic),) ,
                      
                      SizedBox(height: 12,) ,

                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text( "${counterFavorites}" ,style: TextStyle( color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 25 , letterSpacing: 3 , fontStyle: FontStyle.italic)) ,
                                Text("Favoris"  ,style: TextStyle( color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 15 , letterSpacing: -1.00 , fontStyle: FontStyle.italic)) ,
                              ],
                            ),
                          ) ,
                          Column(
                            children: [
                             Text("1"  ,style: TextStyle( color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 25 , letterSpacing: 3 , fontStyle: FontStyle.italic)) ,
                              Text("Reservations"  ,style: TextStyle( color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 15 , letterSpacing: -1.00 , fontStyle: FontStyle.italic)) ,
                            ],
                          )
                        ],
                      )
            
                      ],
                    ),
                  ) ,
                  
                  GestureDetector(
                    onTap: _openReportingPage,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800 ,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                'Ville actuelle',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: IconButton(
                                onPressed: _openReportingPage,
                                icon: Icon(Icons.place_sharp, color: Colors.white, size: 30),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                   Divider(
                      color: Colors.grey.shade700,
                    ),
                   GestureDetector(
                    onTap: _openReportingPage,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800 ,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                'Suggerer une amelioration',
                                style: TextStyle(
                                 color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: IconButton(
                                onPressed: _openReportingPage,
                                icon: Icon(Icons.next_plan_sharp, color: Colors.black, size: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _openReportingPage,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800 ,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                'Reporter un probleme',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: IconButton(
                                onPressed: _openReportingPage,
                                icon: Icon(Icons.next_plan_sharp, color: Colors.black, size: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800 ,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5 ,horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              "Partager l'application",
                              style: TextStyle(
                                    color: Colors.white,
                                  fontSize: 13,
                                    fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.next_plan_sharp, color: Colors.black, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800 ,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              'Desactiver son compte',
                              style: TextStyle(
                                color: Colors.red.shade400,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.next_plan_sharp, color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800 ,
                        borderRadius: BorderRadius.circular(10)
                      ),    
                     padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    child: GestureDetector(
                       onTap: () {
                          // Afficher l'alerte de confirmation
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Voulez-vous vraiment vous déconnecter ?'),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Fermer l'alerte
                                    },
                                    child: Text('Annuler' , style: TextStyle(fontSize: 12 , color: Colors.blue.shade800),),
                                    isDefaultAction: true,
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      // Provider.of<Organisateur>(context, listen: false).logout();
                                      // Provider.of<AuthProvider>(context, listen: false).clearToken();
                                      // Navigator.pushAndRemoveUntil(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => register()),
                                      //   (Route<dynamic> route) => false,
                                      // );

                                      SystemNavigator.pop();

                                    },
                                    child: Text('OK' , style: TextStyle(fontSize: 12),) ,
                                    isDestructiveAction: true,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    'Déconnexion',
                                    style: TextStyle(
                                      color: Colors.red.shade400,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 0),
                                  child: IconButton(
                                    onPressed: null, // L'action est gérée par le GestureDetector
                                    icon: Icon(Icons.next_plan_sharp, color: Colors.white, size: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
            ),
          ),
        ),
      ),
    ) ;
  }


   void _openReportingPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ReportingPage()));
  }
   void _openSuggestionPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => sugestionPage()));
  }
}