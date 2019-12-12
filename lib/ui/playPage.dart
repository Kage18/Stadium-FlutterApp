import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stadium/config/config.dart';
import 'package:web_socket_channel/io.dart';

class PlayPage extends StatefulWidget {
  PlayPage({this.url});
  final String url;

  @override
  State<StatefulWidget> createState() {
    print("ttftftftft");
    print(this.url + "jdhbsgcuybcgyfavcygvc");
//     IOWebSocketChannel _channel;

// int c = 0;
// while(c==0){
//     try {

//       while (c == 0) {

//         _channel = IOWebSocketChannel.connect(this.url);
//         _channel.stream.listen((onData){
//           c = 1;

//         },onError:(){
//           c = 0;
//         })
//         ;

//       }
//     } catch (e) {
//       print("Error");
//     }}

    return new _PlayPageState(channel: IOWebSocketChannel.connect(this.url));
  }
}

class _PlayPageState extends State<PlayPage> {
  _PlayPageState({this.channel});

  final IOWebSocketChannel channel;

  //StreamSubscription _subscription;

  @override
  void initState() {
    print(widget.url + "gvgvgvhg");
    super.initState();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  _sendKey(String input) {
    channel.sink.add(input);
  }

  Widget _showLeftButton() {
    return Opacity(
      opacity: 0.6,
          child: RaisedButton(
          color: Colors.white,
      child: Text(
        "LB",
                style: TextStyle(color: colorCustom,fontWeight: FontWeight.bold,fontSize: 25),
      ),
      elevation: 5,
      onPressed: () {
        _sendKey("9");

        print("LB");
      },
    ));
  }

  Widget _showRightButton() {
    return Opacity(
      opacity: 0.6,
          child: RaisedButton(
          color: Colors.white,
      child: Text(
        "RB",
                style: TextStyle(color: colorCustom,fontWeight: FontWeight.bold,fontSize: 25),
      ),
      elevation: 5,
      onPressed: () {
        _sendKey("8");

        print("RB");
      },
    ));
  }

  Widget _showUpArrow() {
    // return RaisedButton(
    //   color: colorCustom,
    //   child: Icon(Icons.keyboard_arrow_up,color: Colors.white,),
    //   //child: Text("Up",style: TextStyle(color: Colors.white),),
    //   elevation: 5,
    //   onPressed: () {
    //     print("UP");
    //   },
    // );

    return Opacity(
      opacity: 0.6,
          child: Center(
        child: GestureDetector(
      onTap: () {
        print("UP");
        _sendKey("6");
      },
      child: ClipOval(
        child: Container(
          color: Colors.white,
          height: 50, // height of the button
          width: 50.0, // width of the button
          child: Center(
            child: Icon(
              Icons.keyboard_arrow_up,
              color: colorCustom,
            ),
          ),
        ),
      ),
    )));
  }

  Widget _showLLeftArrow() {
    //   return RaisedButton(
    //     color: colorCustom,
    //     child: Icon(Icons.keyboard_arrow_left,color: Colors.white,),
    //     //child: Text("Up",style: TextStyle(color: Colors.white),),
    //     elevation: 5,
    //     onPressed: () {
    //       print("LEFT");
    //     },
    //   );
    //

    return Opacity(
      opacity: 0.6,
          child:  Center(
        child: GestureDetector(
      onTap: () {
        print("LEFT");
        _sendKey("5");
      },
      child: ClipOval(
        child: Container(
          color: Colors.white,
          height: 50, // height of the button
          width: 50.0, // width of the button
          child: Center(
            child: Icon(
              Icons.keyboard_arrow_left,
              color: colorCustom,
            ),
          ),
        ),
      ),
    )));
  }

  Widget _showRightArrow() {
    // return RaisedButton(
    //   color: colorCustom,
    //   child: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
    //   //child: Text("Up",style: TextStyle(color: Colors.white),),
    //   elevation: 5,
    //   onPressed: () {
    //     print("RIGHT");
    //   },
    // );

    return Opacity(
      opacity: 0.6,
          child:  Center(
        child: GestureDetector(
      onTap: () {
        print("RIGHT");
        _sendKey("4");
      },
      child: ClipOval(
        child: Container(
          color: Colors.white,
          height: 50, // height of the button
          width: 50.0, // width of the button
          child: Center(
            child: Icon(
              Icons.keyboard_arrow_right,
              color: colorCustom,
            ),
          ),
        ),
      ),
    )));
  }

  Widget _showDownArrow() {
    // return RaisedButton(
    //   color: colorCustom,
    //   child: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
    //   //child: Text("Up",style: TextStyle(color: Colors.white),),
    //   elevation: 5,
    //   onPressed: () {
    //     print("DOWN");
    //   },
    // );
    return Opacity(
      opacity: 0.6,
          child: Center(
        child: GestureDetector(
      onTap: () {
        print("DOWN");
        _sendKey("7");
      },
      child: ClipOval(
        child: Container(
            color: Colors.white,
          height: 50, // height of the button
          width: 50.0, // width of the button
          child: Center(
            child: Icon(
              Icons.keyboard_arrow_down,
              color: colorCustom,
            ),
          ),
        ),
      ),
    )));
  }

  Widget _showAButton() {
    // return RaisedButton(
    //   color: colorCustom,
    //       child: Text("A",style: TextStyle(color: Colors.white),),
    //       onPressed:(){
    //         print("A");
    //       },
    //       shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(500))
    //     );

    return 
    Opacity(
      opacity: 0.6,
          child: Center(
        child: GestureDetector(
      onTap: () {
        _sendKey("0");
        print("A");
      },
      child: ClipOval(
        child: Container(
            color: Colors.white,
          height: 50, // height of the button
          width: 50.0, // width of the button
          child: Center(
            child: Text(
              "A",
                style: TextStyle(color: colorCustom,fontWeight: FontWeight.bold,fontSize: 25),
            ),
          ),
        ),
      ),
    )));
  }

  Widget _showBButton() {
    // return RaisedButton(
    //   color: colorCustom,
    //       child: Text("B",style: TextStyle(color: Colors.white),),
    //       onPressed:(){
    //         print("B");
    //       },
    //       shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(500))
    //     );

    return Opacity(
      opacity: 0.6,
          child: Center(
            
            
          child: GestureDetector(
        onTap: () {
          print("B");
          _sendKey("1");
        },
        child: ClipOval(
          
          child: Container(
            color: Colors.white,
            height: 50, // height of the button
            width: 50.0, // width of the button
            child: Center(
              child: Text(
                "B",
                style: TextStyle(color: colorCustom,fontWeight: FontWeight.bold,fontSize: 25),
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget _showSelectButton() {
    return Opacity(
      opacity: 0.6,
          child: RaisedButton(
            color: Colors.white,
      child: Text(
        "Select",
                style: TextStyle(color: colorCustom,fontWeight: FontWeight.bold,fontSize: 25),
      ),
      elevation: 5,
      onPressed: () {
        print("SELECT");
        _sendKey("2");
      },
    ));
  }

  Widget _showStartButton() {
    return Opacity(
      opacity: 0.6,
          child:  RaisedButton(
            color: Colors.white,
      child: Text(
        "Start",
                style: TextStyle(color: colorCustom,fontWeight: FontWeight.bold,fontSize: 25),
      ),
      elevation: 5,
      onPressed: () {
        print("START");
        _sendKey("3");
      },
    ));
  }

  Widget _showController() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _showLeftButton(),
              SizedBox(
                width: 30,
              ),
              _showRightButton(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 65,
              ),
              _showUpArrow(),
            ],
          ),
          //LeftRight A and B
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Left Right
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  _showLLeftArrow(),
                  SizedBox(
                    width: 45,
                  ),
                  _showRightArrow(),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
              //A and B
              Row(

                children: <Widget>[
              _showAButton(),
              SizedBox(
                width: 20,
              ),
              _showBButton(),
                SizedBox(
                width: 5,
              ),])
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 65,
              ),
              _showDownArrow(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _showSelectButton(),
              SizedBox(
                width: 30,
              ),
              _showStartButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showGame() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        //width: MediaQuery.of(context).size.width,
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
                    fit: BoxFit.fitWidth,
                    height: 500,
                  )
                : Center(
                    child: Text(
                      //"Sorry, Something went Wrong :("
                      snapshot.error.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget _showBackgrond(){
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _showBackgrond(),
          _showGame(),
          _showController(),
        ],
      ),
    );
  }
}
