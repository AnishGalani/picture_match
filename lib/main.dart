import 'package:flutter/material.dart';
import 'package:picture_match/selectlevel.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: first(),
    debugShowCheckedModeBanner: false,
  ));
}

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);
  static SharedPreferences? prefs;

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  get() async {
    first.prefs = await SharedPreferences.getInstance();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Select mode"),
          actions: [
            IconButton(
                icon: Icon(Icons.volume_down),
                onPressed: () => Icon(Icons.volume_off_sharp)),
            IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => Icon(Icons.volume_off_sharp)),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: 220,
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.teal, width: 5),
                      //color: Colors.teal,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return levals();
                            },
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          width: 180,
                          height: 60,
                          color: Colors.teal,
                          child: Center(
                            child: Text(
                              "NO TIME LIMIT",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        width: 180,
                        height: 60,
                        color: Colors.teal,
                        child: Center(
                          child: Text(
                            "NORMAL",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        width: 180,
                        height: 60,
                        color: Colors.teal,
                        child: Center(
                          child: Text(
                            "HARD",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.teal, width: 5),
              ),
              padding: EdgeInsets.all(5),
              child: Container(
                margin: EdgeInsets.all(5),
                width: 130,
                height: 40,
                color: Colors.teal,
                child: Center(
                  child: Text(
                    "REMOVE ADS",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.teal, width: 5)),
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 130,
                        height: 40,
                        color: Colors.teal,
                        child: Center(
                          child: Text(
                            "SHARE",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        height: 40,
                        color: Colors.teal,
                        child: Center(
                          child: Text(
                            "MORE GAMES",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
