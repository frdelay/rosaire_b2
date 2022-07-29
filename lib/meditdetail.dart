import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'modeles/meditation.dart';
import 'param.dart';

class MeditationDetailScreen extends StatefulWidget {
  final Meditation meditationduJour;
  const MeditationDetailScreen(this.meditationduJour);

  @override
  State<MeditationDetailScreen> createState() => _MeditationDetailScreenState();
}

class _MeditationDetailScreenState extends State<MeditationDetailScreen> {
  final playeraudio = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  //await playeraudio.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.deepPurpleAccent,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: colorTitle[widget.meditationduJour.code[0]],
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Column(children: [
                Container(
                    width: double.infinity,
                    //color:colorTitle[entete[0]],
                    child: Text(widget.meditationduJour.titre,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                        textAlign: TextAlign.center)),
                Container(
                    width: double.infinity,
                    //color:colorTitle[entete[0]],
                    child: Text(widget.meditationduJour.titreEvangile,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center)),
              ]),
            ),
            SizedBox(height: 20.0),
            Container(
              child: Text(widget.meditationduJour.texteEvangile,
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              child: Text(widget.meditationduJour.texteMeditation,
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              child: Text(
                widget.meditationduJour.texteIntentions,
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
                  color: Colors.red, borderRadius: BorderRadius.circular(17)),
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
                    child: Text(widget.meditationduJour.texteFruit,
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
                    child: Text(widget.meditationduJour.texteClausules,
                        style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 20.0),
            if (widget.meditationduJour.imgUrl != "")
              Image(image: NetworkImage(widget.meditationduJour.imgUrl)),
          ],
        ),
      ),
    );
  }
}
