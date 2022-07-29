import 'package:intl/intl.dart';
import 'package:flutter/material.dart';


DateTime now = DateTime.now();
String dayOfWeek = DateFormat.EEEE().format(now);
String day = DateFormat.d().format(now);
int mois = int.parse(DateFormat.M().format(now)) - 1;
String year = DateFormat.y().format(now);

const jourFR = {
  "Monday": "lundi",
  "Tuesday": "mardi",
  "Wednesday": "mercredi",
  "Thursday": "jeudi",
  "Friday": "vendredi",
  "Saturday": "samedi",
  "Sunday": "dimanche"
};

const moisFR = [
  "janvier",
  "février",
  "mars",
  "avril",
  "mai",
  "juin",
  "juillet",
  "août",
  "septembre",
  "octobre",
  "novembre",
  "décembre"
];

const colorTitle = {
  "J": Color(0xffac7a10),
  "L": Color(0xff1957CC),
  "D": Color(0xff96143f),
  "G": Color(0xff2E986E),
};

const famille = {
  "J": "joyeux",
  "L": "lumineux",
  "D": "douloureux",
  "G": "glorieux",
};
