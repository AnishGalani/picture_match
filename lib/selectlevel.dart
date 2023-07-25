import 'package:flutter/material.dart';
import 'package:picture_match/main.dart';
import 'package:picture_match/puzzle_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class levals extends StatefulWidget {
  levals();

  @override
  State<levals> createState() => _levalsState();
}

class _levalsState extends State<levals> {
  int cur_lvl = 0, time = 0;
  List time_list = [];
  bool temp = false;
  List win = [];
  List levelstatus = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cur_lvl = first.prefs!.getInt("levelno") ?? 0;
    print("LevelNO:$cur_lvl");
    levelstatus = List.filled(100, "panding");
    time_list = List.filled(100, "");

    for (int i = 0; i < 30; i++) {
      levelstatus[i] = first.prefs!.getString("levelstatus$i") ?? "panding";
    }

    for (int i = 0; i < 100; i++) {
      time_list[i] = first.prefs!.getInt("time$i") ?? "";
    }
    temp = true;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(
              "SELECT LEVAL",
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () => Icon(Icons.volume_off_sharp),
              ),
              IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () => Icon(Icons.volume_off_sharp)),
            ],
          ),
          body: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, Myind) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide())),
                              child: Text(
                                "${"MATCH ${(Myind)}"}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.question_mark_sharp,
                                size: 20,
                                color: Colors.teal,
                              ),
                              height: 30,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(width: 2, color: Colors.teal),
                                //color: Colors.teal
                              ),
                              // color: Colors.limeAccent,
                            )
                          ],
                        ),
                        Container(
                          height: 350,
                          width: 150,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if ((Myind * 10) + index <= cur_lvl) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Container(
                                            height: 60,
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            color: Colors.teal,
                                            child: Text(
                                              "TIME: NO TIME LIMIT",
                                              // textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          content: Text(
                                            "YOU HAVE 5 SECONDS TO MEMORIES ALL IMAGES",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return puzzle_main(
                                                          (Myind * 10) + index);
                                                    },
                                                  ));
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 60,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Colors.teal,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: Text(
                                                        "GO",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    child: (levelstatus[(Myind * 10) + index] ==
                                            "win")
                                        ? Text(
                                            "LEVEL ${(Myind * 10) + index + 1}-${time_list[index]} ",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          )
                                        : Text(
                                            "LEVEL ${(Myind * 10) + index + 1}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                    margin: EdgeInsets.all(5),
                                    height: 25,
                                    width: 150,
                                    color: (levelstatus[(Myind * 10) + index] ==
                                            "win")
                                        ? Colors.teal
                                        : Colors.grey),
                              );
                            },
                          ),
                        )
                      ]),
                      height: 400,
                      width: 170,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.teal),
                        //color: Colors.tealAccent,
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Are you sure for exit..."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return first();
                        },
                      ));
                    },
                    child: Text("Yes")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("NO"))
              ],
            );
          },
        );
        return true;
      },
    );
  }
}
