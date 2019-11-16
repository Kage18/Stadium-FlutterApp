import 'package:flutter/material.dart';
import 'package:stadium/config/config.dart';

class GamesPage extends StatefulWidget {
  GamesPage({this.games});

  final dynamic games;
  @override
  State<StatefulWidget> createState() => new _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  void initState() {
    super.initState();
  }




Card gameGrid(dynamic game) {
    return new Card(
        elevation: 1.5,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
 AspectRatio(
              aspectRatio: 18.0 / 12.0,
              child: Image.network(serverUrl+game['images'][0]['url']),
              ),
              SizedBox(height: 5,),
            


/*             Image.network(serverUrl+game['images'][0]['url']),
 */            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Center(
                              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(game['name'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                    //new Text(country.nativeName),
                    //new Text(country.capital),
                  ],
                ),
              ),
            )
          ],
        ));
  }











  @override
  Widget build(BuildContext context){
      return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Games"),
      ),
      body: 
     /*  Column(
        children: <Widget>[
          Text(widget.games['games'][0]['images'][0]['url'].toString()),
        ],
      ) */
      
      
      
      GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(widget.games['games'].length, (index) {
        return gameGrid(widget.games['games'][index]);}
      ),


      )
      );

  }
}