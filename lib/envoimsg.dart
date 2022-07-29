import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'accueil.dart';

class UserLog extends StatelessWidget {
  String Prenom = "";
  String Email = "";
  String Numequipe = "";
  String Usernum = "";
  String Login = "";
  String Nummedit = "";

  @override
  void ValidForm(BuildContext ctx) async {
    String urlCreation =
        "http://app.equipes-rosaire.org/user2.php?Prenom=$Prenom&Email=$Email&Numequipe=$Numequipe&Usernum=$Usernum";

    print('ValidForm() ££££££££££££££ urlCreation : ' + urlCreation);

    var uri = Uri.parse(urlCreation);
    var response = await http.post(uri);
    print('ValidForm() ££££££££££££££ Response body: ${response.body}');

    var jsonMedit = jsonDecode(response.body);

    Login = jsonMedit['Login'];
    Prenom = jsonMedit['Prenom'];
    Email = jsonMedit['Email'];
    Numequipe = jsonMedit['Numequipe'];
    Usernum = jsonMedit['Usernum'];
    Nummedit = jsonMedit['Nummedit'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Login', Login);
    print('form.dart : Login = ' + Login);

    Navigator.push(
        ctx, MaterialPageRoute(builder: (ctx) => Accueil(Login)));
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

              height:80,
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
            child: Column(
              children: [
                TextField(
                  onChanged: (text) {
                    print('Champ1 : $text');
                    Prenom = text;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Saisir votre prénom'),
                ),
                TextField(
                  onChanged: (text) {
                    print('Champ2 : $text');
                    Email = text;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Saisir votre email'),
                ),
                TextField(
                  onChanged: (text) {
                    print('Champ3 : $text');
                    Numequipe = text;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Saisir votre numéro d\'équipe'),
                ),
                TextField(
                  onChanged: (text) {
                    print('Champ4 : $text');
                    Usernum = text;
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
                    ValidForm(context);
                  },
                ),
                SizedBox(height: 20.0),
                Text(
                    'En remplissant ce formulaire vous recevrez tous les jours une méditation tenant compte de votre numéro d\'équipier et du calendrier des mystères')
              ],
            ),
          ),
        ),
      );
    });
  }
}
