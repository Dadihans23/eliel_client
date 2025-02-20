import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eliel_client/home/profile.dart';

class ReportingPage extends StatefulWidget {
  const ReportingPage({super.key});

  @override
  State<ReportingPage> createState() => _ReportingPageState();
}

final TextEditingController _problemeController = TextEditingController();

class _ReportingPageState extends State<ReportingPage> {
  bool _isSubmitting = false; // Variable pour contrôler l'état de soumission

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
        centerTitle: true,
        title: Text(
          'Reporter un problème',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              child: Text("Posez votre probème ici",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Container(
                        child: TextField(
                          controller: _problemeController,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                          maxLines: 10, // Définit le nombre maximum de lignes
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade800),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade800),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: _isSubmitting
                            ? null
                            : () {
                                if (_problemeController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Veuillez remplir le champ avant de soumettre."),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _isSubmitting = true;
                                  });

                                  // Simule un délai pour montrer l'animation
                                  Future.delayed(Duration(seconds: 3), () {
                                    setState(() {
                                      _isSubmitting = false;
                                    });

                                    // Après l'animation, navigue vers un nouvel écran
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Profile()));
                                  });
                                }
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo[900],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 80),
                            child: _isSubmitting
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : Text("Envoyer",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
