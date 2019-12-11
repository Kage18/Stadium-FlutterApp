import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stadium/api/userApi.dart';
import 'package:stadium/config/config.dart';
import 'package:stadium/model/parameterModel.dart';

import '../database.dart';
import 'gamePage.dart';

class GamesListPage extends StatefulWidget {
  GamesListPage({this.games});

  final dynamic games;
  @override
  State<StatefulWidget> createState() => new _GamesListPageState();
}

class _GamesListPageState extends State<GamesListPage> {
  String _username;
  @override
  void initState() {
    storeUsername();
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

  storeUsername() async {
    QueryResult result = await getUserId();
    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
      String username =
          result.data.data['me']['Customer']['username'].toString();
      print(username);

      setState(() {
        _username = username;
      });

      print(
          "----------------------------Trying to save Username-----------------");
      Parameter userameParameter = new Parameter();
      userameParameter.parameterName = 'Username';
      userameParameter.parameterValue = username;
      print(userameParameter.parameterValue);
      print(
          "----------------------------Trying to store username-----------------");

      await DBProvider.db.newParameter(userameParameter);

      print(
          "----------------------------Username Stored successfully-----------------");

      print(
          "----------------------------Saved Username successfully-----------------");
    }
  }

  _routeToGamePage(dynamic game) {
    print(game);
    var route = new MaterialPageRoute(
      builder: (BuildContext context) => new GamePage(
        game: game,
        username: _username,
      ),
    );
    Navigator.of(context).push(route);
  }

  Widget gameGrid(dynamic game) {
    return InkWell(
      onTap: () {
        print("sdf");
        _routeToGamePage(game);
      },
      child: new Card(
          elevation: 5,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 18.0 / 12.0,
                child: Image.network(serverUrl + game['images'][0]['url']),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Center(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        game['name'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      //new Text(country.nativeName),
                      //new Text(country.capital),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("Games"),
        ),
        body: widget.games["games"].length == 0
            ? Text(
                "Sorry, No Games to display :(",
                style: TextStyle(color: Colors.black, fontSize: 25),
              )
            :
            /*  Column(
        children: <Widget>[
          Text(widget.games['games'][0]['images'][0]['url'].toString()),
        ],
      ) */

            GridView.count(
                crossAxisCount: 2,
                children: List.generate(widget.games['games'].length, (index) {
                  return gameGrid(widget.games['games'][index]);
                }),
              ));
  }
}
