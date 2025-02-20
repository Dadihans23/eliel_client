import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:eliel_client/auth/register.dart';
import 'package:eliel_client/components/button.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child:Center(
          child: Column(children: [
              const SizedBox(height: 25),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end, // Aligner les éléments verticalement au centre
                   children: [
                    SizedBox(width: 20), // Espace entre l'image et le texte
                    Text( 
                       " E V E N T ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 248, 248, 248), // Couleur du texte
                          fontSize: 24.0, // Taille du texte
                          fontWeight: FontWeight.bold, // Épaisseur de la police
                          letterSpacing: 0.5, // Espacement entre les lettres
                          decorationStyle: TextDecorationStyle.double, // Style de la décoration du texte
                        ),
                    ),
                  ]
                ),
              ),

              const SizedBox(height: 20),

              Container(
              child: Column(children:
               [
                Image.asset("lib/images/intro.png", width: 300, height: 350,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text( 
                       "Obtiens tes tickets pour les evements les plus branchés",
                       textAlign: TextAlign.center ,
                        style: TextStyle(
                          color: Colors.black, // Couleur du texte
                          fontSize: 14.0, // Taille du texte
                          fontWeight: FontWeight.normal,// Épaisseur de la police
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.4, // Espacement entre les lettres
                          decorationStyle: TextDecorationStyle.double, // Style de la décoration du texte
                        ),
                      ),
                ),
                const SizedBox(height: 20),
                Button(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => RegisterPage(),
                          transitionDuration: Duration(milliseconds: 700), // Durée de la transition en millisecondes
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                  },
                  buttonText: " Demarrer",
                  ),

                ],),
              ),

          ],),
        ),
      ),
    );;
  }
}