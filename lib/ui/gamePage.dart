import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stadium/api/containerApi.dart';
import 'package:stadium/api/gamesApi.dart';
import 'package:stadium/api/userApi.dart';
import 'package:stadium/config/config.dart';
import 'package:stadium/ui/playPage.dart';

import 'homePage.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;

  ShowUp({@required this.child, this.delay});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}

class GamePage extends StatefulWidget {
  GamePage({this.game, this.username});

  final dynamic game;
  final String username;
  @override
  State<StatefulWidget> createState() => new _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int delayAmount = 600;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }



  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }





  buy() async {
    QueryResult result = await buyGame(widget.game['id']);

    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
      toast("Successfully Bought");
      var route = new MaterialPageRoute(
        builder: (BuildContext context) => new HomePage(),
      );
      Navigator.of(context)
          .pushAndRemoveUntil(route, (Route<dynamic> route) => false);
    }
  }




  _routeToPlay(String gameId) async{

     setState(() {
      _isLoading = true;
    });
    Timer(Duration(seconds: 10), () {
          setState(() {
            _isLoading = false;
          });
        });

  print(gameId);





String userId;

QueryResult result = await getUserId();

    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
     userId = result.data.data["me"]["id"];
    }









print(userId+"/////////////////////////");
print(gameId);









   dynamic url = await getContainerUrl(gameId, userId);
   String containerUrl = url["url"];



         var route = new MaterialPageRoute(
          builder: (BuildContext context) => new PlayPage(
            url: containerUrl,
          ),
        );
        Navigator.of(context)
            .push(route);

  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Buy " + widget.game['name']),
          content: new Text("Buy " +
              widget.game['name'] +
              "for Rs. " +
              widget.game['price'].toString() +
              " ?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Confirm"),
              onPressed: () {
                buy();
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showImage() {
    return ShowUp(
      delay: delayAmount - 200,
      child: Center(
        child: new Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(
                        serverUrl + widget.game['images'][0]['url'])))),
      ),
    );
  }

  Widget _showName() {
    return ShowUp(
      delay: delayAmount,
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: new Text(
            widget.game['name'],
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
          )),
    );
  }

  Widget _showDescription() {
    return ShowUp(
        delay: delayAmount + 200,
        child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: new Text(
              widget.game['description'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            )));
  }

  Widget _showButtons() {
    int c = 0;
    for (int i = 0; i < widget.game["gameOwnedSet"].length; i++) {
      if (widget.username ==
          widget.game["gameOwnedSet"][i]["customer"]["Customer"]["username"]) {
        c = 1;
      }
    }

    if (c == 0) {
      return ShowUp(
        delay: delayAmount + 500,
        child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0)),
                  elevation: 5.0,
                  minWidth: 150,
                  height: 42.0,
                  color: colorCustom,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Buy',
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white)),
                    ],
                  ),
                  onPressed: () {
                    print("hello");
                    _showDialog();
                  },
                ),
                // SizedBox(
                //   width: 20,
                // ),
                // MaterialButton(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: new BorderRadius.circular(18.0)),
                //   elevation: 5.0,
                //   minWidth: 150,
                //   height: 42.0,
                //   color: colorCustom,
                //   child: Row(
                //     children: <Widget>[
                //       Icon(
                //         Icons.play_arrow,
                //         color: Colors.white,
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Text('Play',
                //           style: new TextStyle(
                //               fontSize: 20.0, color: Colors.white)),
                //     ],
                //   ),
                 
                //   onPressed: () {
                //       _routeToPlay(widget.game["id"]);
               
                //   },
                // ),
              ],
            )),
      );
    } else {
      return ShowUp(
        delay: delayAmount + 500,
        child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0)),
                  elevation: 5.0,
                  minWidth: 150,
                  height: 42.0,
                  color: colorCustom,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Play',
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white)),
                    ],
                  ),
                   onPressed: () {
                      _routeToPlay(widget.game["id"]);
               
                  },
               
                ),
              ],
            )),
      );
    }
  }

  Widget _showBody(){
    return  ListView(
        children: <Widget>[
          _showImage(),
          _showName(),
          _showDescription(),
          _showButtons(),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(widget.game['name']),
      ),
      body:Stack(children: <Widget>[
        _showBody(),
        _showCircularProgress(),
      ],)
    );
  }
}
