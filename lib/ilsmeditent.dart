import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class IlsMeditent extends StatefulWidget {
  const IlsMeditent({Key? key}) : super(key: key);

  @override
  State<IlsMeditent> createState() => _IlsMeditentState();
}

class _IlsMeditentState extends State<IlsMeditent> {
 

  List<Map> usersConnected = [];
  

  @override
  void initState() {
    super.initState();
    getConnectPhp();
  }


     getConnectPhp() async {
    var uri = Uri.parse("http://app.equipes-rosaire.org/journal2.php");
    var response = await http.post(uri);

    var jsonConnexions = jsonDecode(response.body);
    print(jsonConnexions);

    jsonConnexions.forEach((data) {
      print(data);
      usersConnected.add(data);
    });

    ;

    setState(() {
      usersConnected = usersConnected;
    });

    
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.deepPurpleAccent,),
            onPressed: () {Navigator.pop(context);}),
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
      body:             ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: usersConnected.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Text(usersConnected[index]["Meditation"],
                          style: TextStyle(backgroundColor: Colors.black26)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Text(usersConnected[index]["Prenom"]),
                          Text(usersConnected[index]["DateConnexion"]),
                        ],
                      ),
                    ],
                  );
                }),
    );
  }
}