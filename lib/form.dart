import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'accueil.dart';

class UserLog extends StatelessWidget {
  String uPrenom = "";
  String uEmail = "";
  String uNumequipe = "";
  String uUsernum = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void ValidForm(BuildContext ctx) async {
    // on appel la requete serveur

    String urlCreation =
        "http://app.equipes-rosaire.org/user2.php?Prenom=$uPrenom&Email=$uEmail&Numequipe=$uNumequipe&Usernum=$uUsernum";
    print('ValidForm() urlCreation : ' + urlCreation);
    var uri = Uri.parse(urlCreation);
    var response = await http.post(uri);

    print('Response body: ${response.body}');
    var jsonMedit = jsonDecode(response.body);

    String uLogin = jsonMedit['Login'];
    // String uNummedit = jsonMedit['Nummedit'];

    // on sauvegarde Login ( id )
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ppLogin', uLogin);
    print('form.dart : Login = ' + uLogin);

    Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => Accueil(uLogin)));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          title: Center(
            child: Container(
              height: 80,
              child: Image.asset(
                'assets/EdR_splash.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter text';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      print('Champ1 : $text');
                      uPrenom = text;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Saisir votre prénom'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter text';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      print('Champ2 : $text');
                      uEmail = text;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Saisir votre email'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter text';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      print('Champ3 : $text');
                      uNumequipe = text;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Saisir votre numéro d\'équipe'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter text';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      print('Champ4 : $text');
                      uUsernum = text;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Saisir votre numéro d\'équipier'),
                  ),
                  TextButton(
                    child: Text('Créer votre compte'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                    onPressed: () {
                      // on verifie que les champs ne sont plus vide
                      if (_formKey.currentState!.validate()) {
                        ValidForm(context);
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                      'En remplissant ce formulaire vous recevrez tous les jours une méditation tenant compte de votre numéro d\'équipier et du calendrier des mystères')
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
