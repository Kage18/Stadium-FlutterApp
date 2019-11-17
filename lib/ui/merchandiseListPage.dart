import 'package:flutter/material.dart';
import 'package:stadium/config/config.dart';
import 'merchandisePage.dart';

class MerchandiseListPage extends StatefulWidget {
  MerchandiseListPage({this.allMerchandise});

  final dynamic allMerchandise;
  @override
  State<StatefulWidget> createState() => new _MerchandiseListPageState();
}

class _MerchandiseListPageState extends State<MerchandiseListPage> {
  @override
  void initState() {
    super.initState();
  }

  _routeToMerchandisePage(dynamic merchandise) {
    var route = new MaterialPageRoute(
      builder: (BuildContext context) => new MerchandisePage(
        merchandise: merchandise,
      ),
    );
    Navigator.of(context).push(route);
  }

  Widget merchGrid(dynamic merch) {
    return InkWell(
      onTap: () {
        print("sdf");
        _routeToMerchandisePage(merch);
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
                child: Image.network(serverUrl + merch['images'][0]['url']),
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
                        merch['name'],
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
          title: new Text("Merchandise"),
        ),
        body:
            /*  Column(
        children: <Widget>[
          Text(widget.games['games'][0]['images'][0]['url'].toString()),
        ],
      ) */

            GridView.count(
          crossAxisCount: 2,
          children:
              List.generate(widget.allMerchandise['merchs'].length, (index) {
            return merchGrid(widget.allMerchandise['merchs'][index]);
          }),
        ));
  }
}
