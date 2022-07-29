import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:rosaire/ilsmeditent.dart';
import 'package:rosaire/meditdetail.dart';
import 'package:rosaire/notif_help.dart';
import 'modeles/meditation.dart';
import 'param.dart';
import 'affichsite.dart';
import 'ilsmeditent.dart';

class Accueil extends StatefulWidget {
  final String login;

  const Accueil(this.login);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  //variables globales
  String prenom = "";
  String email = "";
  String usernum = "";
  String numequipe = "";
  int nummedit = 0;
  bool isLoading = true;

  Meditation meditationdujour = Meditation();

  @override
  void initState() {
    super.initState();
    getUserPhp(widget.login);
    NotificationService().init();
    generateNotif();
  }

//on efface et on genere les notif pour 30 jours
  generateNotif() {
    NotificationService()
        .showNotifDate(DateTime.now().add(Duration(seconds: 10)));
  }

  // on récupère les données de l'utilisateur depuis la shared préference Login
  void getUserPhp(String loginId) async {
    print(
        "medit.dart : uri = http://app.equipes-rosaire.org/user2.php?Login=$loginId");
    var uri =
        Uri.parse("http://app.equipes-rosaire.org/user2.php?Login=$loginId");
    var response = await http.post(uri);
    var jsonMedit = jsonDecode(response.body);
    print('getUserPhp() ££££££££££££££ Response body: ${response.body}');
    setState(() {
      prenom = jsonMedit['Prenom'];
      email = jsonMedit['Email'];
      numequipe = jsonMedit['Numequipe'];
      usernum = jsonMedit['Usernum'];
      nummedit = int.parse(jsonMedit['Nummedit']) - 1;
    });
    await getMeditations();

    setState(() {
      isLoading = false;
    });
  }

  getMeditations() async {
    var meditations = await Meditation.getMeditPhp();

    setState(() {
      meditationdujour = meditations[nummedit];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(30.0),
              child: ListView(
                children: [
                  Text("Bonjour $prenom !",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: colorTitle[meditationdujour.code[0]],
                      )),
                  RichText(
                    text: TextSpan(
                      text:
                          "aujourd'hui, ${jourFR[dayOfWeek]} $day ${moisFR[mois]}  $year, vous méditez un ",
                      style: TextStyle(
                          fontSize: 15,
                          color: colorTitle[meditationdujour.code[0]]),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                "mystère ${famille[meditationdujour.code[0]]}",
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: colorTitle[meditationdujour.code[0]],
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Column(children: [
                      Container(
                          width: double.infinity,
                          //color:colorTitle[entete[0]],
                          child: Text(meditationdujour.titre,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white),
                              textAlign: TextAlign.center)),
                      Container(
                          width: double.infinity,
                          //color:colorTitle[entete[0]],
                          child: Text(meditationdujour.titreEvangile,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                              textAlign: TextAlign.center)),
                    ]),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Text(meditationdujour.texteEvangile,
                        style: GoogleFonts.lato(
                            fontStyle: FontStyle.italic, fontSize: 14)),
                  ),
                  SizedBox(height: 20.0),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/ico1.png',
                        height: 30,
                        width: 30,
                      ),
                      Text("Méditation",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Text(meditationdujour.texteMeditation,
                        style: TextStyle(fontSize: 14)),
                  ),
                  SizedBox(height: 20.0),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/ico2.png',
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        "Intentions",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Text(
                      meditationdujour.texteIntentions,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(17)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/ico3.png',
                              height: 30,
                              width: 30,
                            ),
                            Text("Fruit du mystère",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: Text(meditationdujour.texteFruit,
                              style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/ico4.png',
                              height: 30,
                              width: 30,
                            ),
                            Text("Les clausules",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: Text(meditationdujour.texteClausules,
                              style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(height: 20.0),
                  if (meditationdujour.imgUrl != "")
                    Image(image: NetworkImage(meditationdujour.imgUrl)),
                ],
              ),
            ),
      bottomSheet: Container(
          child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AfficheSite(),
                  ));
            },
            child: const Text('Vers le site'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IlsMeditent(),
                  ));
            },
            child: const Text('ils méditent'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('laisser un message'),
          ),
        ],
      )),
    );
  }
}
