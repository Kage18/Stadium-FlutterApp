
import 'package:flutter/material.dart';

class FriendProfilePage extends StatefulWidget {
  FriendProfilePage({this.user});

  final dynamic user;
  @override
  State<StatefulWidget> createState() => new _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {


  @override
  void initState() {
    super.initState();
  }


 Widget _showUsername() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: new Text(
          widget.user['Customer']['username'],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }

  Widget _showGender() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            new Text(
              "Gender: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new Text(
              widget.user['gender'] == 1
                  ? "Male"
                  : widget.user['gender'] == 0 ? "Female" : "Other",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }

  Widget _showPhone() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            new Text(
              "Phone: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new Text(
              widget.user['phoneNo'],
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }

  Widget _showJoined() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            new Text(
              "Member Since: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new Text(
              widget.user['joined'],
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }

  Widget _showAbout() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Wrap(
          direction: Axis.horizontal,
          children: <Widget>[
            new Text(
              "About: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new Text(
              widget.user['about'] == null
                  ? "Tell us something about yourself!"
                  : widget.user['about'],
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }

  Widget _showDob() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            new Text(
              "Date of Birth: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new Text(
              widget.user['DOB'],
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }

  Widget _showDivider() {
    return Divider(
      thickness: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Profile"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          _showUsername(),
          _showDivider(),
          _showGender(),
          _showDivider(),
          _showDob(),
          _showDivider(),
          _showPhone(),
          _showDivider(),
          _showJoined(),
          _showDivider(),
          _showAbout(),
        ],
      ),
    );
  }

}