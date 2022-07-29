import 'dart:convert';
import 'package:http/http.dart' as http;

class Meditation {
  String nummedit = " ";
  String code = "G";
  String titre = "";
  String titreEvangile = "";
  String texteEvangile = "";
  String texteMeditation = "";
  String texteIntentions = "";
  String texteFruit = "";
  String texteClausules = "";
  String imgUrl = "";
  String audioUrl = "";
  String videoUrl = "";


  static Meditation fromJson(Map<String, dynamic> json) {
    var medit = Meditation();
    medit.nummedit = json["Nummedit"];
    medit.code = json["Code"];
    medit.titre = json["Titre"];
    medit.titreEvangile = json["TitreEvangile"];
    medit.texteMeditation = json["TexteMeditation"];

    medit.texteEvangile = json["TexteEvangile"];
    medit.texteMeditation = json["TexteMeditation"];
    medit.texteIntentions = json["TexteIntentions"];
    medit.texteFruit = json["TexteFruit"];
    medit.texteClausules = json["TexteClausules"];
    medit.imgUrl = "http://app.equipes-rosaire.org/Img/"+json["Img"];
    medit.audioUrl = json["Audio"];
    medit.videoUrl = json["Video"];
    return medit;
  }

// on récupère la liste des méditations et on retourne un tableau Objet de type Méditation
  static Future<List<Meditation>> getMeditPhp() async {
    var uri = Uri.parse("http://app.equipes-rosaire.org/json2.php");
    var response = await http.post(uri);
    var jsonMedit = jsonDecode(response.body);
    List<Meditation> meditations = [];

    jsonMedit.forEach((data) {
      var meditation = Meditation.fromJson(data);
      meditations.add(meditation);
    });
    return meditations;
  }
}

