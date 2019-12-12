import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stadium/config/config.dart';
import 'package:web_socket_channel/io.dart';

class PlayPage extends StatefulWidget {
  PlayPage({this.game, this.username});

  final dynamic game;
  final String username;
  @override
  State<StatefulWidget> createState() => new _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final channel = IOWebSocketChannel.connect('ws://10.0.32.170:8080');
  //StreamSubscription _subscription;
  //Image img;

  @override
  void initState() {
    // _subscription = channel.stream.listen((data) {
    //   setState(() {
    //           img = Image.memory(data);

    //   });
    // });
    super.initState();
  }

  @override
  void dispose() {
    //_subscription?.cancel();
    channel.sink.close();
    super.dispose();
  }





  Widget _showLeftButton() {
    return RaisedButton(
      color: colorCustom,
      child: Text("LB",style: TextStyle(color: Colors.white),),
      elevation: 5,
      onPressed: () {
        print("LB");
      },
    );
  }

  Widget _showRightButton() {
    return RaisedButton(
      color: colorCustom,
      child: Text("RB",style: TextStyle(color: Colors.white),),
      elevation: 5,
      onPressed: () {
        print("RB");
      },
    );
  }
 Widget _showUpArrow() {
    return RaisedButton(
      color: colorCustom,
      child: Icon(Icons.keyboard_arrow_up,color: Colors.white,),
      //child: Text("Up",style: TextStyle(color: Colors.white),),
      elevation: 5,
      onPressed: () {
        print("UP");
      },
    );
  }
 Widget _showLLeftArrow() {
    return RaisedButton(
      color: colorCustom,
      child: Icon(Icons.keyboard_arrow_left,color: Colors.white,),
      //child: Text("Up",style: TextStyle(color: Colors.white),),
      elevation: 5,
      onPressed: () {
        print("LEFT");
      },
    );
  }
 Widget _showRightArrow() {
    return RaisedButton(
      color: colorCustom,
      child: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
      //child: Text("Up",style: TextStyle(color: Colors.white),),
      elevation: 5,
      onPressed: () {
        print("RIGHT");
      },
    );
  }
 Widget _showDownArrow() {
    return RaisedButton(
      color: colorCustom,
      child: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
      //child: Text("Up",style: TextStyle(color: Colors.white),),
      elevation: 5,
      onPressed: () {
        print("DOWN");
      },
    );
  }

  Widget _showAButton(){
    return RaisedButton(
      color: colorCustom,
          child: Text("A",style: TextStyle(color: Colors.white),),
          onPressed:(){
            print("A");
          },
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(500))
        );
  }


  Widget _showController() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _showLeftButton(),
            SizedBox(width: 30,),
             _showRightButton(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 50,),
            _showUpArrow(),
          ],
        ),
        Row(
          children: <Widget>[
            _showLLeftArrow(),
            _showRightArrow(),
            _showAButton(),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            padding: EdgeInsets.all(0),
            child: StreamBuilder(
              stream: channel.stream,
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? Image.memory(
                        snapshot.data,
                        gaplessPlayback: true,
                        width: MediaQuery.of(context).size.width,
                      )
                    : Text(
                        snapshot.error.toString(),
                        style: TextStyle(fontSize: 20),
                      );
              },
            ),
          ),
          _showController(),
        ],
      ),
    );
  }
}
