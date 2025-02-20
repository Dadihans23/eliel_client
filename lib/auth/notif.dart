import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:eliel_client/home/homepage.dart';


class AllowNotifications extends StatefulWidget {
  const AllowNotifications({super.key});

  @override
  State<AllowNotifications> createState() => _AllowNotificationsState();
}

class _AllowNotificationsState extends State<AllowNotifications> {
  @override


   void initState() {
    super.initState();
    // Délai de 1 seconde avant d'afficher la boîte de confirmation
    Future.delayed(const Duration(seconds: 1), () {
      _showConfirmationDialog();
    });
  }


  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
                  title: Text("Activer les Notifications"),
                  content: Text("Souhaitez-vous activer les notifications pour recevoir les meilleures offres et événements exclusifs ?",),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fermer l'alerte
                      },
                      child: Text('Refuser' , style: TextStyle(fontSize: 12 , color: Colors.blue.shade800),),
                      isDefaultAction: true,
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text('Autoriser' , style: TextStyle(fontSize: 12),) ,
                      isDestructiveAction: true,
                    ),
                  ],
                );


        
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50 , vertical: 15) ,
                      child: Container(
                        height: 5 ,
                        color: Colors.indigo[900],
                      ),
                    ),
                  ) ,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
                    child: Text("VOULEZ VOUS RECEVOIR DES NOTIFICATIONS" , style: TextStyle( color: Colors.black , fontWeight: FontWeight.bold , fontSize: 20 , letterSpacing: -1.00)),
                  ) ,
                  
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
                    child: Text("Assurez-vous d'être parmi les premiers à découvrir toutes les meilleures offres et événements exclusifs." , style: TextStyle( color: Colors.grey.shade500 , fontWeight: FontWeight.w600 , fontSize: 15 , letterSpacing: -1.00)),
                  ) ,
                ],
              ),
            ) ,
            

            Container(
              padding: EdgeInsets.symmetric( horizontal: 10),
              child: Icon(Icons.notifications , size: 200,),
            ) ,
            SizedBox(height: 20,) ,
            GestureDetector(
            onTap: (){
              Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
              (Route<dynamic> route) => false,
            );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0 , vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.indigo[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "Continuer",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ),
             
          ],
        ),
      ),
    ),
    );
  }
}