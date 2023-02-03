import 'package:flutter/material.dart';
import 'package:hangman/utils.dart';
import 'dart:math';

// STFL -> name: "GameScreen"
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // --------------------------------- BUILD THE LOGIC ---------------------------------

  // grab a random word from the word list
  String word = wordList[Random().nextInt(wordList.length)];
  List guessedCharacters = [];
  int points = 0;
  int lifeCount = 0;

  List images = [
    "images/hangman0.png",
    "images/hangman1.png",
    "images/hangman2.png",
    "images/hangman3.png",
    "images/hangman4.png",
    "images/hangman5.png",
    "images/hangman6.png",
  ];

  // create the dialog window that pops up after the game ends
  openDialog(String title) {
    return showDialog(
      // to prevent skipping the "Play again" button
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 180,
            decoration: BoxDecoration(color: Colors.purpleAccent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: retroStyle(25, Colors.white, FontWeight.bold),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 5,
                ),
                Text("Your total points: $points",
                    style: retroStyle(20, Colors.white, FontWeight.bold),
                    textAlign: TextAlign.center),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextButton(
                    // when "Play again" button is pressed, reset the game
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        lifeCount = 0;
                        points = 0;
                        guessedCharacters.clear();
                        // generete new random word
                        word = wordList[Random().nextInt(wordList.length)];
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        "Play again",
                        style: retroStyle(20, Colors.black, FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // logic for guessing a word
  String handleText() {
    String dispayword = "";

    for (int i = 0; i < word.length; i++) {
      String char = word[i];

      if (guessedCharacters.contains(char)) {
        dispayword += char + " ";
      } else {
        dispayword += "? ";
      }
    }

    return dispayword;
  }

  // logic for checking if a word contains the entered characters
  checkLetter(String alphabet) {
    if (word.contains(alphabet)) {
      setState(() {
        guessedCharacters.add(alphabet);
        points += 5;
      });
    } else if (lifeCount != 6) {
      setState(() {
        lifeCount += 1;
        points -= 5;
      });
    } else {
      // print("You lost the game.");
      openDialog("You lost!");
    }

    bool isWon = true;

    for (int i = 0; i < word.length; i++) {
      String char = word[i];

      if (!guessedCharacters.contains(char)) {
        setState(() {
          isWon = false;
        });

        break;
      }
    }

    if (isWon) {
      // print("You won!");
      openDialog("Hurray, you won!");
    }
  }

  @override
  Widget build(BuildContext context) {
    // --------------------------------- BUILD THE UI ---------------------------------
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Hangman",
          style: retroStyle(30, Colors.white, FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(color: Colors.lightBlueAccent),
                height: 30,
                child: Center(
                  child: Text(
                    "$points points",
                    style: retroStyle(15, Colors.black, FontWeight.w700),
                  ),
                ),
              ),
              // for spacing
              SizedBox(
                height: 20,
              ),
              Image(
                // image: AssetImage("images/hangman0.png"),
                image: AssetImage(images[lifeCount]),
                width: 155,
                height: 155,
                color: Colors.white,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                //"7 lives left",
                "${7 - lifeCount} lives left",
                style: retroStyle(18, Colors.grey, FontWeight.w700),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                handleText(),
                style: retroStyle(35, Colors.white, FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(left: 10, right: 10),
                childAspectRatio: 1.3,
                // iterate through all english characters
                children: letters.map((alphabet) {
                  return InkWell(
                    onTap: () => checkLetter(alphabet),
                    child: Center(
                      child: Text(
                        alphabet,
                        style: retroStyle(20, Colors.white, FontWeight.w700),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
