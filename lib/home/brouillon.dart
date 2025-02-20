import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart'; // Importez la bibliothèque intl
import 'package:eliel_client/models/eventfuture.dart';
import 'package:eliel_client/models/ticketCategorie.dart'; // Importez votre modèle de catégorie de billets
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eliel_client/util/constant.dart';


class EventDetailsPage extends StatefulWidget {
  final Event event;

  EventDetailsPage({required this.event});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
 String baseUrl = Constants.adresse;

  late Future<List<TicketCategory>> ticketCategories;
  bool isLoading = true; // État de chargement
  String? selectedCategory; // Catégorie de billet sélectionnée
  final phoneController = TextEditingController(); // Contrôleur pour le numéro de téléphone
  final _formKey = GlobalKey<FormState>(); // Clé pour valider le formulaire

  @override
  void initState() {
    super.initState();
    ticketCategories = fetchTicketCategories(widget.event.id);
  }

  Future<List<TicketCategory>> fetchTicketCategories(int eventId) async {
    final response = await http.post(
      Uri.parse('http://${baseUrl}:8000/users/get-ticket-categories/'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"event_id": eventId}),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((category) => TicketCategory.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load ticket categories');
    }
  }

  // Méthode pour afficher la modale d'achat de ticket
  void showPurchaseModal(BuildContext context, List<TicketCategory> categories) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permet de faire défiler la fenêtre
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Gérer l'affichage du clavier
          ),
          child: Form(
            key: _formKey, // Associer la clé au formulaire
            child: Container(
              padding: EdgeInsets.all(20),
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Acheter un ticket',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'Numéro de téléphone (10 chiffres)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un numéro de téléphone';
                      } else if (value.length != 10) {
                        return 'Le numéro doit contenir 10 chiffres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    hint: Text('Sélectionnez une catégorie de billet'),
                    items: categories.map((TicketCategory category) {
                      return DropdownMenuItem<String>(
                        value: category.categoryName,
                        child: Text(category.categoryName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Veuillez sélectionner une catégorie de billet';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Gérer l'achat du billet ici
                        print('Numéro de téléphone: ${phoneController.text}');
                        print('Catégorie sélectionnée: $selectedCategory');
                        Navigator.pop(context); // Ferme la modale après validation
                      }
                    },
                    child: Center(
                      child: Text(
                        'Confirmer l\'achat',
                        style: TextStyle(fontSize: 16),
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

  @override
  Widget build(BuildContext context) {
    String adresse = '192.168.3.151';
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.06;
    final event = widget.event;
    DateTime eventDate = DateTime.parse(widget.event.date);

    String day = DateFormat('dd', 'fr_FR').format(eventDate);
    String month = DateFormat('MMMM', 'fr_FR').format(eventDate);
    String hour = DateFormat('HH', 'fr_FR').format(eventDate);
    String weekday = DateFormat('EEEE', 'fr_FR').format(eventDate);
    String year = DateFormat('yyyy', 'fr_FR').format(eventDate);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 37, 136),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 08, vertical: 20),
            child: Column(
              children: [
                // Les autres widgets ici...

                FutureBuilder<List<TicketCategory>>(
                  future: ticketCategories, // Utilisez l'ID de l'événement pour récupérer les catégories
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Affiche un indicateur de chargement
                    } else if (snapshot.hasError) {
                      return Text('Erreur: ${snapshot.error}');
                    } else {
                      List<TicketCategory> categories = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            showPurchaseModal(context, categories);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.indigo.shade600,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(1, 5),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: Text(
                              "Acheter un ticket",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}









// <manifest xmlns:android="http://schemas.android.com/apk/res/android">

//     <application
//         android:label="eliel_client"
//         android:name="${applicationName}"
//         android:icon="@mipmap/ic_launcher">
//         <activity
//             android:name=".MainActivity"
//             android:exported="true"
//             android:launchMode="singleTop"
//             android:theme="@style/LaunchTheme"
//             android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
//             android:hardwareAccelerated="true"
//             android:windowSoftInputMode="adjustResize">
//             <!-- Specifies an Android theme to apply to this Activity as soon as
//                  the Android process has started. This theme is visible to the user
//                  while the Flutter UI initializes. After that, this theme continues
//                  to determine the Window background behind the Flutter UI. -->
//             <meta-data
//               android:name="io.flutter.embedding.android.NormalTheme"
//               android:resource="@style/NormalTheme"
//               />
//             <intent-filter>
//                 <action android:name="android.intent.action.MAIN"/>
//                 <category android:name="android.intent.category.LAUNCHER"/>
//             </intent-filter>
//         </activity>
//         <!-- Don't delete the meta-data below.
//              This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
//         <meta-data
//             android:name="flutterEmbedding"
//             android:value="2" />
//     </application>
//     <!-- Required to query activities that can process text, see:
//          https://developer.android.com/training/package-visibility?hl=en and
//          https://developer.android.com/reference/android/content/Intent#ACTION_PROCESS_TEXT.

//          In particular, this is used by the Flutter engine in io.flutter.plugin.text.ProcessTextPlugin. -->
//     <queries>
//         <intent>
//             <action android:name="android.intent.action.PROCESS_TEXT"/>
//             <data android:mimeType="text/plain"/>
//         </intent>
//     </queries>
// </manifest>
