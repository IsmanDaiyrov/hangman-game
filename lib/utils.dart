import 'package:flutter/material.dart';

// create a reference to the font style
TextStyle retroStyle(double size, [Color? color, FontWeight? fw]) {
  return TextStyle(
      fontFamily: "RetroGaming", color: color, fontSize: size, fontWeight: fw);
}

// store the word list
List wordList = ["FLUTTER", "CAR", "GOOGLE", "DOG", "FOOD", "PYTHON"];

// store all english characters for the keyboard
List<String> letters = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
