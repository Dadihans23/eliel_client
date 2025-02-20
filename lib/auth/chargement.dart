import 'package:flutter/material.dart';
import 'package:eliel_client/auth/notif.dart';

class Loadingpage extends StatefulWidget {
  const Loadingpage({super.key});

  @override
  State<Loadingpage> createState() => _LoadingpageState();
}

class _LoadingpageState extends State<Loadingpage> {
  @override

   void initState() {
    super.initState();
    // Démarre un timer pour attendre 3 secondes
    Future.delayed(Duration(seconds: 3), () {
      // Après 3 secondes, navigue vers la page suivante
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AllowNotifications()),
      );
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Loader circulaire
      ),
    );  }
}