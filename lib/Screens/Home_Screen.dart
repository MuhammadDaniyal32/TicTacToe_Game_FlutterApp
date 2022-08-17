import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_game/Screens/Leaderboard_Screen.dart';
import '../Models/Game_Model.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
    List<List<dynamic>> game_grid = [
      ["","",""],
      ["","",""],
      ["","",""]
    ];
    int game_turns=0;
    bool isPlayer_1=true;
    bool isPlayer_2 =false;
    List<Game_Model> winnner_detail=[];

    @override
  void initState() {
    super.initState();
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
             children: [
               Padding(
                 padding: EdgeInsets.only(top: 71,left: 70),
                 child: LayoutBuilder(builder: (context, constraints) {
                   if(isPlayer_1){
                     return Card(elevation: 30,shape: CircleBorder(),child: Image(image: AssetImage('assets/images/player_1_icon.png'),height: 75,width: 75));
                   }
                   return Image(image: AssetImage('assets/images/player_1_icon.png'),height: 75,width: 75);
                 })
               ),
               Padding(
                 padding: EdgeInsets.only(top: 87,left: 20),
                 child:Text("VS",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 40,color:Color(0xffDBDBDB))),
               ),
               Padding(
                 padding: EdgeInsets.only(top: 71,left: 20,right: 70),
                 child: LayoutBuilder(builder: (context, constraints) {
                   if(isPlayer_2){
                     return Card(elevation: 30,shape: CircleBorder(),child: Image(image: AssetImage('assets/images/player_2_icon.png'),height: 75,width: 75));
                   }
                   return Image(image: AssetImage('assets/images/player_2_icon.png'),height: 75,width: 75);
                 })
               ),
             ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 11,left: 69),
                child:Text("Player 1",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 22,color:Color(0xff656565))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 11,left: 93,right: 59),
                child:Text("Player 2",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 22,color:Color(0xff656565))),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 36,left: 10,right: 10),
                height: 413,
                width: 369,
                  decoration: BoxDecoration(image: DecorationImage(image:AssetImage('assets/images/borderbox.png'))),
                child: Stack(
                  children: [
                    Column(
                    children:[
                            ...game_grid.asMap().map((index_col, value_col) => MapEntry(index_col, Row(
                              children: [
                                ...value_col.asMap().map((index_row, value_row) => MapEntry(index_row,
                                    Container(
                                      height: 137,
                                      width: 123,
                                      child: OnGameBoard_tap(index_col,index_row,value_row),
                                    )
                                )).values.toList(),
                              ],
                            ))).values.toList(),
                      ],
                  ),
                    //SizedBox(width: 100,height: 100,child: Line(),)
                  ]
                )
              )
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 35,left: 10),
                width: 200,
                height: 62,
                child: ElevatedButton.icon(label: Text("Leader board",style: GoogleFonts.poppins(fontSize: 18,fontWeight:FontWeight.w600)), icon: Image(image: AssetImage('assets/images/list_icon.png')),onPressed: ()=>onleaderboard(),style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                        )
                    ),
                  backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xff0D47A1),),
                ),),
              ),

              Container(
                  margin: EdgeInsets.only(top: 35,left: 110,right: 10),
                  child: InkWell(borderRadius: BorderRadius.circular(30),onTap:()=>onreset(), child: Icon(Icons.refresh,color: Color(0xff0D47A1),size: 50))
              )
            ],
          )
        ],
      ),
    );
  }

    OnGameBoard_tap(int index_col,int index_row,var value) {
      return GestureDetector(
        onTap: () {
          if (game_turns != 9 && value == "") {
            if (isPlayer_1) {
              setState(() {
                game_grid[index_col][index_row] = "0";
                isPlayer_2 = true;
                isPlayer_1 = false;
                game_turns++;
              });
              if (gamewinner(index_col, index_row, "0")) {
                game_turns=9;
                winnner_detail.add(Game_Model(true,false));
                Future.delayed(Duration(milliseconds: 500),() {
                showDialog(context: context, builder: (BuildContext context) => dialog("Player 1","WON",'assets/images/trophy_large.png',Color(0xff0D47A1)));
                onreset();
                });
              }
              else if(gamewinner(index_col, index_row, "0") == false && game_turns == 9){
                winnner_detail.add(Game_Model(false, false));
                Future.delayed(Duration(milliseconds: 500),() {
                showDialog(context: context, builder: (BuildContext context) => dialog("","Game Draw!!!",'assets/images/logo.png',Color(0xff42A5F5)));
                onreset();});
              }
            }
            else if (isPlayer_2) {
              setState(() {
                game_grid[index_col][index_row] = "1";
                isPlayer_2 = false;
                isPlayer_1 = true;
                game_turns++;
              });
              if (gamewinner(index_col, index_row, "1")) {
                game_turns=9;
                winnner_detail.add(Game_Model(false,true));
                Future.delayed(Duration(milliseconds: 500),() {
                showDialog(context: context, builder: (BuildContext context) => dialog("Player 2","WON",'assets/images/trophy_large.png',Color(0xff0D47A1)));
                onreset();});
              }
              else if(gamewinner(index_col, index_row, "1") == false && game_turns == 9){
                Future.delayed(Duration(milliseconds: 500),() {
                winnner_detail.add(Game_Model(false,false));
                showDialog(context: context, builder: (BuildContext context) => dialog("","Game Draw",'assets/images/logo.png',Color(0xff0D47A1)));
                onreset();});
              }
            }
          }
        },
        child: LayoutBuilder(builder: (context, constraints) {
          if (value != "") {
            if (value == "0") {
              return Image(image: AssetImage('assets/images/0_icon.png'),
                  height: 75,
                  width: 75);
            }
            else if (value == "1") {
              return Image(image: AssetImage('assets/images/X_icon.png'),
                  height: 75,
                  width: 75);
            }
          }
          return Text("");
        }),
      );
    }
  bool gamewinner(int index_col,int index_row,var value){
          //row check
              if (game_grid[index_col][0] == game_grid[index_col][1] && game_grid[index_col][1] == game_grid[index_col][2])
              {
                return true;
              }
          // column check
              if (game_grid[0][index_row] == game_grid[1][index_row] && game_grid[1][index_row] == game_grid[2][index_row])
              {
                return true;
              }
          // left diagonal check
              if (game_grid[0][0] == game_grid[1][1] && game_grid[1][1] == game_grid[2][2] && game_grid[0][0] != "")
              {
                return true;
              }
          // right diagonal check
              if (game_grid[0][2] == game_grid[1][1] && game_grid[1][1] == game_grid[2][0] && game_grid[0][2] != "")
              {
                return true;
              }

    return false;
  }

  onreset() {
    setState(() {
      game_grid = [
        ["","",""],
        ["","",""],
        ["","",""]
      ];
      game_turns=0;
       isPlayer_1=true;
       isPlayer_2=false;
    });
  }

  onleaderboard() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => Leaderboard_Screen(winnner_detail:winnner_detail)));
  }
}
Widget dialog (String player_name,String txt,String image_path,Color color){
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)), //this right here
    backgroundColor:color,
    elevation: 10.0,
    child: Container(
      height: 422,
      width: 369,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.only(top: 51,left: 78,right: 79,bottom: 28),
            child: Image(image: AssetImage(image_path)),
          ),
          Text(player_name,style: GoogleFonts.poppins(fontSize: 20,fontWeight:FontWeight.w400,color: Colors.white,letterSpacing: 1)),
          Text(txt,style: GoogleFonts.poppins(fontSize: 40,fontWeight:FontWeight.w700,color: Colors.white)) ,
        ],
      ),
    ),
  );
}
