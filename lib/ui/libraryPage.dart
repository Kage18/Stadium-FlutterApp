import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stadium/api/containerApi.dart';
import 'package:stadium/api/userApi.dart';
import 'package:stadium/config/config.dart';
import 'package:stadium/ui/playPage.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({this.library});

  final dynamic library;
  @override
  State<StatefulWidget> createState() => new _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {



    bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

/*
  _routeToGamePage(dynamic game) {
    var route = new MaterialPageRoute(
      builder: (BuildContext context) => new GamePage(
        game: game,
      ),
    );
    Navigator.of(context).push(route);
  }
*/




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




  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }




  _routeToPlay(String gameId) async{

  print(gameId);

setState(() {
      _isLoading = true;
    });
    Timer(Duration(seconds: 10), () {
          setState(() {
            _isLoading = false;
          });
        });





  

String userId;

QueryResult result = await getUserId();

    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
     userId = result.data.data["me"]["id"];
    }







   dynamic url = await getContainerUrl(gameId,userId);
   String containerUrl = url["url"];



         var route = new MaterialPageRoute(
          builder: (BuildContext context) => new PlayPage(
            url: containerUrl,
          ),
        );
        Navigator.of(context)
            .push(route);

  }





  Widget libraryTile(dynamic game) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: new Text(
          game['game']['name'],
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
        subtitle: new Text("Minutes Played: " +
                game['hoursPlayed'].toString() +
                "\n"
                    "Rating: " +
                game['rating'].toString()

            /* style: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w400), */
            ),
        trailing: InkWell(
          onTap:() {_routeToPlay(game["game"]["id"]);}
          
          
          
          
          ,
                  child: Icon(
            
            Icons.play_arrow,
            color: colorCustom[600],
            size: 50,
          ),
        ),
      ),
    );
  }

  Widget _showBody(){
    return 
    
                //widget.library["gameOwned"].length == 0 ? Text("You don't own any games :(", style: TextStyle(color: Colors.black, fontSize: 25),) :
ListView.builder(
                itemCount: widget.library['gameOwned'].length,
                itemBuilder: (BuildContext context, int index) {
                  return libraryTile(widget.library['gameOwned'][index]);
                });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("Your Games"),
        ),
        body: Stack(children: <Widget>[
          _showBody(),
          _showCircularProgress()
        ],));


           
  }
}
