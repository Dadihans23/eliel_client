// import 'package:flutter/material.dart';
// import 'package:eliel_client/auth/register.dart';
// import 'package:eliel_client/home/homepage.dart';
// import 'package:eliel_client/intro.dart';  // Assurez-vous que ce chemin est correct
// import 'package:eliel_client/provider/favorisProvider.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
// import 'package:eliel_client/provider/authprovider.dart';

// // void main() => runApp(MyApp());  // Passez MyApp à runApp

// void main() => runApp(
//   MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (context) => AuthProvider()),
//       ChangeNotifierProvider(create: (context) => FavoritesProvider()),

//     ],
//     child: MyApp(),
//   ),
// );



// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: RegisterPage(), 
//       // home: RegisterPage(),  // Assurez-vous que IntroPage est bien défini dans intro.dart

//       // ajoutez ici d'autres configurations de MaterialApp si nécessaire
//     );
//   }
// }



import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:uni_links/uni_links.dart';
import 'package:eliel_client/auth/register.dart';
import 'package:eliel_client/home/homepage.dart';
import 'package:eliel_client/intro.dart';  // Assurez-vous que ce chemin est correct
import 'package:eliel_client/provider/favorisProvider.dart';
import 'package:provider/provider.dart';
import 'package:eliel_client/provider/authprovider.dart';
import 'package:eliel_client/provider/ticketprovider.dart';



void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => FavoritesProvider()),
      // ChangeNotifierProvider(create: (context) => TicketProvider()),
    ],
    child: MyApp(),
  ),
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _linkSubscription;

  @override
  void initState() {
    super.initState();
    // Démarre l'écoute des liens profonds
    // _initDeepLinkListener();
  }

  // Fonction pour écouter les liens profonds
  // void _initDeepLinkListener() async {
  //   _linkSubscription = linkStream.listen((String? link) {
  //     if (link != null && link.contains("paiement-termine")) {
  //       // Redirige vers la page spécifique après paiement
  //       Navigator.pushReplacementNamed(context, '/page-apres-paiement');
  //     }
  //   }, onError: (err) {
  //     print('Erreur de lien profond : $err');
  //   });
  // }

  @override
  void dispose() {
    _linkSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),  // Page d'accueil
      routes: {
        '/page-apres-paiement': (context) => PaymentConfirmationPage(),
        // Ajoutez d'autres routes ici si nécessaire
      },
    );
  }
}

class PaymentConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation de paiement'),
      ),
      body: Center(
        child: Text('Merci pour votre paiement !'),
      ),
    );
  }
}

