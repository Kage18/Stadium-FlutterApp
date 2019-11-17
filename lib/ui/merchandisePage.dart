import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stadium/config/config.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;

  ShowUp({@required this.child, this.delay});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}

class MerchandisePage extends StatefulWidget {
  MerchandisePage({this.merchandise});

  final dynamic merchandise;
  @override
  State<StatefulWidget> createState() => new _MerchandisePageState();
}

class _MerchandisePageState extends State<MerchandisePage> {
  int delayAmount = 600;

  @override
  void initState() {
    super.initState();
  }

  Widget _showImage() {
    return ShowUp(
      delay: delayAmount - 200,
      child: Center(
        child: new Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(
                        serverUrl + widget.merchandise['images'][0]['url'])))),
      ),
    );
  }

  Widget _showName() {
    return ShowUp(
      delay: delayAmount,
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: new Text(
            widget.merchandise['name'],
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
          )),
    );
  }

  Widget _showDescription() {
    return ShowUp(
      delay: delayAmount + 200,
      child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: new Text(
            widget.merchandise['desc'],
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          )),
    );
  }

  Widget _showButtons() {
    return ShowUp(
      delay: delayAmount + 500,
      child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0)),
                elevation: 5.0,
                minWidth: 250,
                height: 50.0,
                color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Buy',
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white)),
                  ],
                ),
                onPressed: () {
                  print("hello");
                },
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(widget.merchandise['name']),
      ),
      body: ListView(
        children: <Widget>[
          _showImage(),
          _showName(),
          _showDescription(),
          _showButtons(),
        ],
      ),
    );
  }
}
