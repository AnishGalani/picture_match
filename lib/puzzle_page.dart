import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picture_match/main.dart';
import 'package:picture_match/selectlevel.dart';
import 'package:picture_match/selectlevel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class puzzle_main extends StatefulWidget {
  int cur_ind;

  puzzle_main(this.cur_ind);

  @override
  State<puzzle_main> createState() => _puzzle_mainState();
}

class _puzzle_mainState extends State<puzzle_main> {
  List all_img = [];
  List puzzle_img = [];
  bool temp = false;
  int a = 0,
      cur_lvl = 0,
      x = 0,
      cnt = 0,
      click = 1,
      pos1 = 0,
      pos2 = 0,time=0;
  List<bool> temp_time = [];
  int store_time=0;
  List list = [];
  bool stop = false;
  List level_ind=[12,16,20,24,28,32,36,40,44,48];

  Future get_img() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      all_img = imagePaths;
      all_img.shuffle();
      for (int i = 0; i < level_ind[widget.cur_ind]/2; i++) {
        puzzle_img.add(all_img[i]);
        puzzle_img.add(all_img[i]);
      }
      puzzle_img.shuffle();
      temp = true;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("CURIND=${widget.cur_ind}");
    get_img().then(
          (value) {
            temp_time = List.filled(level_ind[widget.cur_ind], true);
          },
    );

    set_timer();
    list = List.filled(level_ind[widget.cur_ind], "No");
    for (int i = 0; i < cur_lvl; i++) {
      list[i] = first.prefs!.getString("level$i");
    }
    print(list);
  }

  set_timer() async {
    for (int i = 5; i >= 0; i--) {
      a = i;
      if (i == 0) {
        temp_time = List.filled(level_ind[widget.cur_ind], false);
      }
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
    }
    for (int j = 0; j < 10000; j++) {
      if(stop==true){
        break;
      }
      a = j;
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Time: $a/0"),
          actions: [
            IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () => Icon(Icons.volume_off_sharp)),
            IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => Icon(Icons.volume_off_sharp)),
          ],
        ),
        body: (temp)
            ? Container(
          margin: EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: level_ind[widget.cur_ind],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (temp_time[index] == false) {
                    if (click == 1 && temp_time[index] == false) {
                      temp_time[index] = true;
                      pos1 = index;
                      click = 0;
                      Future.delayed(Duration(milliseconds: 20)).then(
                            (value) {
                          click = 2;
                          setState(() {});
                        },
                      );
                      setState(() {});
                    }
                    if (click == 2 && temp_time[index] == false) {
                      temp_time[index] = true;
                      pos2 = index;
                      click = 0;
                      if (puzzle_img[pos1] == puzzle_img[pos2]) {
                        first.prefs!.setString("levelstatus${widget.cur_ind}", "win");
                        cnt++;
                        Future.delayed(Duration(microseconds: 50)).then(
                              (value) {
                            click = 1;
                            setState(() {});
                          },
                        );
                      } else {
                        Future.delayed(Duration(seconds: 1))
                            .then((value) {
                          temp_time[pos1] = false;
                          temp_time[pos2] = false;
                          click = 1;

                          setState(() {});
                        });
                      }
                    }

                    setState(() {});
                    time = a;
                  }
                  if (cnt == level_ind[widget.cur_ind]/2) {
                    stop = true;
                    setState(() {

                    });
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Congratulation!!!"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  first.prefs!.setInt("time${widget.cur_ind}",time);
                                  widget.cur_ind++;
                                  first.prefs!.setInt("levelno", widget.cur_ind);
                                  setState(() {
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return levals();
                                        },
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.teal,
                                          border: Border.all(
                                              color: Colors.white)),
                                      child: Text(
                                        "ok",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white),
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
                child: Visibility(
                    visible: temp_time[index],
                    replacement: Container(
                      decoration: BoxDecoration(
                          border: Border.all(), color: Colors.teal),
                    ),
                    child: Container(
                      height: 400,
                      width: 170,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image:
                              AssetImage("${puzzle_img[index]}"))),
                    )),
              );
            },
          ),
        )
            : CircularProgressIndicator(),
      ),
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
                          return levals();
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
