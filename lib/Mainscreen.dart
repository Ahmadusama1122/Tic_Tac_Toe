import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({Key? key}) : super(key: key);

  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  bool check = true;
  List<String> display = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  var textstyle=GoogleFonts.happyMonkey(color: Colors.white,fontSize: 30);
  int playero=0;
  int playerx=0;
  int filledbox=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(15)),
                  Column(
                    children: [
                      Text('Player O',style: textstyle,),
                      Text(playero.toString(),style: textstyle,),
                    ],
                  ),
                  SizedBox(
                    width: 90,
                  ),
                  Column(
                    children: [
                      Text('Player X',style: textstyle,),
                      Text(playerx.toString(),style: textstyle,),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      displaytest(index);
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Text(
                          display[index],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
            color: Colors.grey[700],
          )),
        ],
      ),
    );
  }

  void displaytest(int index) {
    setState(() {
      if (check && display[index] == '') {
        display[index] = 'o';
        filledbox+=1;
      } else if (!check && display[index] == '') {
        display[index] = 'x';
        filledbox+=1;
      }
    });
    check = !check;
    check_winner();
  }

  void check_winner() {
    if (display[0] == display[1] &&
        display[0] == display[2] &&
        display[0] != '') {
      show_dialog(display[0]);
    }
    if (display[3] == display[4] &&
        display[3] == display[5] &&
        display[3] != '') {
      show_dialog(display[3]);
    }
    if (display[6] == display[7] &&
        display[6] == display[8] &&
        display[6] != '') {
      show_dialog(display[6]);
    }
    if (display[0] == display[3] &&
        display[0] == display[6] &&
        display[0] != '') {
      show_dialog(display[0]);
    }
    if (display[1] == display[4] &&
        display[1] == display[7] &&
        display[1] != '') {
      show_dialog(display[1]);
    }
    if (display[2] == display[5] &&
        display[2] == display[8] &&
        display[2] != '') {
      show_dialog(display[2]);
    }
    if (display[0] == display[4] &&
        display[0] == display[8] &&
        display[0] != '') {
      show_dialog(display[0]);
    }
    if (display[2] == display[4] &&
        display[2] == display[6] &&
        display[2] != '') {
      show_dialog(display[2]);
    }
    else if(filledbox==9){
      drawdialog();
    }
  }

  void show_dialog(String WINNER) {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('winner is ' + WINNER),
            actions: [
              FlatButton(onPressed: (){
                clear_board();
                Navigator.of(context).pop();
              },
                  child: Text('Play Again'),
              )
            ],
          );
        });
      if(WINNER=='o'){
        playero+=1;
      }
      else if(WINNER=='x'){
        playerx+=1;
      }
  }
  void clear_board(){
    setState(() {
      for(int i=0;i<9;i++){
        display[i]='';
      }
      filledbox=0;
    });
  }
  void drawdialog(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Match is draw'),
        actions: [
          FlatButton(onPressed: (){
            clear_board();
            Navigator.of(context).pop();
          },
            child: Text('Play Again'),
          )
        ],
      );
    });
  }
}
