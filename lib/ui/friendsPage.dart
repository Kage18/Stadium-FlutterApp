import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stadium/api/friendsApi.dart';
import 'package:stadium/api/userApi.dart';
import 'package:stadium/config/config.dart';
import 'package:stadium/ui/profilePage.dart';

import 'friendProfilePage.dart';
import 'homePage.dart';

class FriendsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  //dynamic allFriends;
  String friendEmail;
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

  getAllFriends() async {
    QueryResult result = await getAllFriendsApi();
    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
      print("//////////////////////////////////////////////");
      print(result.data.data["me"]["friends"]);

      return result.data.data["me"]["friends"];
    }
  }

  getPendingRequests() async {
    QueryResult result = await getAllPendingRequests();
    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
      print(
          "////////////////////****************Showing Pending Requests*****************//////////////////////////");
      print(result.data.data);

      return result.data.data["pendingRequests"];
    }
  }

  _routeToFriendProfile(dynamic user) {
    print(
        "------------------------------------***********************************************************-------------------------------------------");
    print(user);
    var route = new MaterialPageRoute(
      builder: (BuildContext context) => new FriendProfilePage(
        user: user,
      ),
    );
    Navigator.of(context).push(route);
  }

  Widget _showFriends() {
    return FutureBuilder(
        future: getAllFriends(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ?
              //  Center(child: Text("Yes Friends",style: TextStyle(fontSize: 30),))
              ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title:
                            Text(snapshot.data[index]["Customer"]["username"]),
                        onTap: () {
                          _routeToFriendProfile(snapshot.data[index]);
                        },
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                  "No Friends",
                  style: TextStyle(fontSize: 30),
                ));
        });
  }

  _acceptRequest(String email) async {
    QueryResult result = await sendFriendRequest(email);
    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
      toast("Request Accepted");

      var route = new MaterialPageRoute(
        builder: (BuildContext context) => new HomePage(),
      );
      Navigator.of(context)
          .pushAndRemoveUntil(route, (Route<dynamic> route) => false);
    }
  }

  Widget _showRequests() {
    return FutureBuilder(
        future: getPendingRequests(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData && snapshot.data.length != 0
              ?
              //  Center(child: Text("Yes Friends",style: TextStyle(fontSize: 30),))
              ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(snapshot.data[index]["fromUser"]["Customer"]
                            ["username"]),
                        subtitle: Text("EmailId: " +
                            snapshot.data[index]["fromUser"]["Customer"]
                                ["email"]),
                        trailing: InkWell(
                          child: Icon(
                            Icons.add,
                            size: 40,
                            color: colorCustom,
                          ),
                          onTap: () {
                            print("edrftgyh");

                            _acceptRequest(snapshot.data[index]["fromUser"]
                                    ["Customer"]["email"]
                                .toString());
                          },
                        ),
                        onTap: () {
                          print("xedcfvgbhnj");
                        },
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                  "No Pending Requests",
                  style: TextStyle(fontSize: 30),
                ));
        });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Confirmation"),
          content: new Text("Send a friend request to " + friendEmail + " ?"),
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
                _sendRequest();
              },
            ),
          ],
        );
      },
    );
  }

  _sendRequest() async {
    QueryResult result = await sendFriendRequest(friendEmail);
    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
      toast("Request sent");

      var route = new MaterialPageRoute(
        builder: (BuildContext context) => new HomePage(),
      );
      Navigator.of(context)
          .pushAndRemoveUntil(route, (Route<dynamic> route) => false);
    }
  }

  Widget _addFriend() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(
              "Please enter the email address of a user to send them a friend request",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              onSubmitted: (String value) {
                setState(() {
                  friendEmail = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0)),
                  elevation: 5.0,
                  minWidth: 50,
                  height: 42.0,
                  color: colorCustom,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Send Request',
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white)),
                    ],
                  ),
                  onPressed: () {
                    print(friendEmail);
                    print("hello");
                    _showDialog();
                  },
                ),
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            // tabs: [
            //   Tab(icon: Icon(Icons.directions_car)),
            //   Tab(icon: Icon(Icons.directions_transit)),
            //   Tab(icon: Icon(Icons.directions_bike)),
            // ],
            tabs: [
              Tab(
                text: "My Friends",
              ),
              Tab(
                text: "  Add" + "\n" + "Friend",
              ),
              Tab(
                text: " Pending" + "\n" + "Requests",
              ),
            ],
          ),
          title: Text('Friends'),
        ),
        body: TabBarView(
          children: [_showFriends(), _addFriend(), _showRequests()],
        ),
      ),
    );
  }
}
