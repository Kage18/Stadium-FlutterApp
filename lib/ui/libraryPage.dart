import 'package:flutter/material.dart';
import 'package:stadium/config/config.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({this.library});

  final dynamic library;
  @override
  State<StatefulWidget> createState() => new _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
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
  Widget libraryTile(dynamic game) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: new Text(
          game['game']['name'],
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
        subtitle: new Text(
          "Hours Played: " + game['hoursPlayed'].toString()+ "\n"
          "Rating: " + game['rating'].toString()

          /* style: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w400), */
        ),
        trailing: Icon(
          Icons.play_arrow,
          color: colorCustom[600],
          size: 50,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("Your Games"),
        ),
        body: 
        
        
                //widget.library["gameOwned"].length == 0 ? Text("You don't own any games :(", style: TextStyle(color: Colors.black, fontSize: 25),) :

        
        ListView.builder(
            itemCount: widget.library['gameOwned'].length,
            itemBuilder: (BuildContext context, int index) {
              return libraryTile(widget.library['gameOwned'][index]);
            }));
  }
}
