import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project2/Register.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

  List<List<int>> gridNumbers = List.generate(
    3,
        (_) => List.generate(3, (_) => Random().nextInt(9) + 1),
  );

  void update(int row, int col) {
    setState(() {
      Random random = Random();
      gridNumbers[row][col] = random.nextInt(9)+1;
    });
  }
  int? choice1 ;
  int? choice2 ;
  int score = 0;
  int bestScore = 0;
  int i = 3;
  void clear(){
    setState(() {
      choice1 = 0;
      choice2 = 0;
    });
  }
  void dec(){
    setState(() {
      i--;
    });
    if(i==0){
      setState(() {
        if(score > bestScore) bestScore = score;
        score = 0;
        i = 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Just Play'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0;i < 3; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int j = 0; j < 3; j++)
                Container(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                    ),child: Text('${gridNumbers[i][j]}',
                  style: TextStyle(fontSize: 20),),
                      onPressed: (){
                        setState(() {
                          if (choice1 == null) {
                            choice1 = gridNumbers[i][j];
                          } else if(choice2 == null){
                            choice2 = gridNumbers[i][j];
                          }
                        });
                        update(i,j);
                        if((choice1!+choice2!)%2 ==0 && (choice1!+choice2!) !=0){
                        setState(() {
                          choice1 = null;
                          choice2 = null;
                          score = score + 100;
                        });} else{
                          choice2 = null;
                          dec();
                        };
                      },
                  ),
                ),
              ],
            ),SizedBox(height: 20),

          Container(
            width: 200, height: 100,
              child:
              Text('Number 1: $choice1 ' + 'Number 2: $choice2\n'
                  'Score: $score\n'
                  'Best Score: $bestScore\n'
                  '$i tries left\n',
              style: TextStyle(fontSize: 15),)),
          SizedBox(height: 20,),
          Container(width: 100,height: 50,
          color: Colors.red,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
              onPressed: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context)=>Page2(bestScore),),);
          },
              child: Text('Finish')),)
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final int bestScore;

  Page2(this.bestScore);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        title: Text('Final Score'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('The game finished\n'
                'Your best score is : $bestScore',
            style: TextStyle(fontSize: 20),),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
                onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Game(),),);
            },
                child: Text('Try Again')),
            SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>Register(),),);
                },
                child: Text('End')),
          ],
        ),
      ),
    );
  }
}
