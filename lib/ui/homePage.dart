import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stadium/api/gamesApi.dart';
import 'package:stadium/api/profileApi.dart';
import 'package:stadium/ui/profilePage.dart';

import '../database.dart';
import 'gamesPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {


    bool _isLoading = false;

  List<Image> items = [
    Image.asset(
      'assets/images/img1.jpg',
      height: 200,
    ),
    Image.asset(
      'assets/images/img2.jpg',
      height: 200,
    ),
    Image.asset(
      'assets/images/img3.jpg',
      height: 200,
    ),
    Image.asset(
      'assets/images/img4.jpg',
      height: 200,
    ),
    Image.asset(
      'assets/images/img5.jpg',
      height: 200,
    ),
    Image.asset(
      'assets/images/img6.jpg',
      height: 200,
    ),
  ];

  String username = "User";

  getUsername() async {
    print(
        "----------------------------Trying to get Username-----------------");

    dynamic use = await DBProvider.db.getParameter('Username');
    //print(use.parameterValue);
    if (use != Null) {
      setState(() {
        username = use.parameterValue;
      });
    }

    print(
        "----------------------------Got Username successfully-----------------");
  }

  @override
  void initState() {
    getUsername();
    super.initState();
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

 void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }

routeToProfile() async {

  setState(() {
    _isLoading = true;
  });
  QueryResult result = await profileData();
   if (result.hasErrors) {
        print("Sorry bruh...");
        toast(result.errors[0].toString());
      } else {
        dynamic user = result.data.data;
          setState(() {
    _isLoading = false;
  });


var route = new MaterialPageRoute(
          builder: (BuildContext context) => new ProfilePage(user: user,),
        );
        Navigator.of(context)
            .push(route);


      }


}












_routeToGames() async {

  setState(() {
    _isLoading = true;
  });
  QueryResult result = await allGames();
   if (result.hasErrors) {
        print("Sorry bruh...");
        toast(result.errors[0].toString());
      } else {
        dynamic games = result.data.data;
          setState(() {
    _isLoading = false;
  });


var route = new MaterialPageRoute(
          builder: (BuildContext context) => new GamesPage(games: games,),
        );
        Navigator.of(context)
            .push(route);

 
      }


}













Widget _showBody(){
      return new Container(

  padding: EdgeInsets.zero,
  
  child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.zero,
                child: CarouselSlider(
                  items: items,
                  height: 200,
                  
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: Duration(seconds: 10),
                  enlargeCenterPage: true,
                  //onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                )),
            new Text(
              "ABC",
              style: new TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ));
  
  
  
  
  
  
  
}


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(centerTitle: true, title: new Text("Stadium")),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hello, $username',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        'My Profile',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onTap: () {
                     routeToProfile();
                      },
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.games,
                ),
                title: Text(
                  'Games',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  _routeToGames();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.store,
                ),
                title: Text(
                  'Merchandise',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.library_books,
                ),
                title: Text(
                  'Library',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ), 
              Divider(
                height: 15,
                thickness: 3,
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
            _showCircularProgress(),
          ],
        ));
  }







}
