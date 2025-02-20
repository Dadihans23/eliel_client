import 'package:flutter/material.dart';


import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:eliel_client/home/decouvrir.dart';
import 'package:eliel_client/home/favoris.dart';
import 'package:eliel_client/home/profile.dart';
import 'package:eliel_client/home/tickets.dart';



import 'package:provider/provider.dart';
import 'package:eliel_client/provider/authprovider.dart';

import 'package:eliel_client/provider/favorisProvider.dart';

class Homepage extends StatefulWidget {
  
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  
  int _selectedIndex = 0;
  late List<Widget> _pages ;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);
    final FavorisProvider = Provider.of<FavoritesProvider>(context);
    final username = auth.getUsername() ;


    String? tokenClient = auth.getToken();

    _pages= [
    Decouvrir(
      tokenClient: tokenClient,
      favoritesEvent: FavorisProvider.favoriteEvents, // Passer les événements favoris
      favoritesProvider: FavorisProvider, // Passer le provider
      username : username ,
    ),   
    TicketsPage(tokenClient: tokenClient,),
    FavorisPage( username : username ,tokenClient: tokenClient),
    Profile(),


  ];
    return Scaffold(
      
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            duration: Duration(milliseconds: 700),
            haptic: true,
            backgroundColor: Colors.black,
            gap: 10,
            color: Colors.white,
            activeColor: Colors.white,
            iconSize: 24,
            tabBackgroundColor: const Color.fromARGB(255, 28, 37, 136),
            padding: EdgeInsets.all(10),
            tabs: [
              GButton(
                icon: Icons.event_available_outlined,
                text: 'Decouvrir',
              ),
              GButton(
                icon: Icons.qr_code,
                text: 'Mes tickets',
              ),
              GButton(
                icon: Icons.favorite_border_rounded,
                text: 'Favoris',
              ),
              GButton(
                icon: Icons.person,
                text: 'Moi',
              ),
            ],
          ),
        ),
      ),
    );
  }
}