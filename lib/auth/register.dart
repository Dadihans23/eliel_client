import 'package:flutter/material.dart';
import 'package:eliel_client/auth/chargement.dart';
import 'package:eliel_client/auth/login.dart';

import 'package:eliel_client/components/custominput.dart';
import 'package:eliel_client/components/custompassword.dart';
import 'package:eliel_client/service/get_ticket_service.dart';


import 'package:provider/provider.dart';
import 'package:eliel_client/provider/authprovider.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eliel_client/util/constant.dart';








class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}


final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
      String baseUrl = Constants.adresse;


class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final auth =Provider.of<AuthProvider>(context);




  void _registerUser() async {
  String name = _nameController.text.trim();
  String surname = _surnameController.text.trim();
  String email = _emailController.text.trim();
  String password = _passwordController.text.trim();
  String confirmPassword = _confirmPasswordController.text.trim();

  // Débogage : Afficher les valeurs des champs


  if (name.isEmpty || surname.isEmpty ||  email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
    _showErrorDialog("Veuillez remplir tous les champs.");
    return;
  }

  if (password != confirmPassword) {
    _showErrorDialog("Les mots de passe ne correspondent pas.");
    return;
  }

  // Vérification du format de l'email
  RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegExp.hasMatch(email)) {
    _showErrorDialog("Veuillez entrer une adresse email valide.");
    return;
  }

  // Toutes les vérifications sont passées, continuer avec le traitement des données

   Map<String, dynamic> requestBody = {
    'email': email, 
    'nom': name ,
    'prenom': surname ,
    'password': password

  };

// {
//      "email": "tes9t@example.com",
//      "nom": "test_user",
//      "prenom": "carloo" ,
//      "password": "12345678"
// }

  // Convertir le corps de la requête en JSON
  
String jsonBody = json.encode(requestBody);
 String adresse = baseUrl;

  
// Définir l'URL de ton API Django
String apiUrl = 'http://$adresse:8000/users/Register_client/';

  // Enregistrer l'utilisateur, etc.

try {
  // Effectuer la requête POST
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonBody,
  );
     
  // Décode la réponse en tant que JSON en spécifiant l'encodage des caractères
  Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));

  // Vérifier si la requête a réussi (code de statut 200)
  if (response.statusCode == 200 || response.statusCode == 201 ) {
    // Vérifier si la réponse de l'API contient "success" à true

     print(jsonResponse['token']);
     print(jsonResponse['username']);
     auth.setToken(jsonResponse['token']);
     auth.setUsername(jsonResponse['username']);
    
      print("permier etape bien recu");
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondryAnimation) => Loadingpage(
          ),
          transitionDuration: Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
      // Afficher le message d'erreur de l'API
    }
   else {
    // Traitement en cas d'échec
    print('Échec de l\'inscription. Code de statut: ${response.statusCode}');

    _showErrorDialog(jsonResponse['message']);

  }
} catch (error) {
  // cas d'erreurs
  print('Erreur lors de la requête POST: $error');
}

 
  ;
  }
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body:Container(
        child: SingleChildScrollView(
          physics:BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 50,) ,
              Image.asset("lib/images/intro.png", width: 200, height: 150,),
              Container(
                child: Column(
                  children: [
                    CustomTextinput(
                      hintText: 'Entrez votre nom',
                      prefixIcon: null,
                      controller: _nameController,
                    ) ,
                    CustomTextinput(
                      hintText: 'Entrez votre prenom',
                      prefixIcon: null,
                      controller: _surnameController,
                    ) ,
                    CustomTextinput(
                      hintText: 'Entrez votre email',
                      prefixIcon: null,
                      controller: _emailController,
                    ),
                      PasswordTextField(
                    controller: _confirmPasswordController,
                    hintText: ' Entrez votre mot de passe',
                    suffixIconData: Icons.visibility,
                    prefixIcon:null,
                  )  , 
                    PasswordTextField(
                      controller: _passwordController,
                      hintText: ' Confirmer votre mot de passe',
                      suffixIconData: Icons.visibility,
                      prefixIcon:null,
                    ), 
          
                    SizedBox(height: 15,),
          
                    GestureDetector(
                                  onTap: _registerUser,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 0 , vertical: 15),
                                    margin: const EdgeInsets.symmetric(horizontal: 50),
                                    decoration: BoxDecoration(
                                      color: Colors.indigo[900],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Inscription",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()) );
                                      },
                                      child: Container(
                                        child: Text("deja un compte ?" ,style: TextStyle(color: Colors.black , fontSize: 12 , fontWeight:FontWeight.bold),),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey.shade900,
                                      ),
                                    )
                                  ],
                                ),
                
                    
          
                  ],
                ),
              )
          
            ],
          ),
        ),
      )
    );
  }

  // void _registerUser(){
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Loadingpage())) ;
  // }






void _showErrorDialog(String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        title: Text("Erreur"  , style :TextStyle( color: Colors.indigo[900] , fontSize: 18, fontWeight:FontWeight.bold),),
        content: Text(message , style: TextStyle(color: Colors.black , fontSize: 14, fontWeight:FontWeight.w700),),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}
}