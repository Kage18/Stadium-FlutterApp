import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stadium/api/loginApi.dart';
import 'package:stadium/api/signupApi.dart';
import 'package:stadium/model/parameterModel.dart';
import '../database.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'homePage.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LandingPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LandingPageState extends State<LandingPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _phone;
  String _password;
  String _errorMessage;
  String _username;
  DateTime dob = DateTime.now();
  String dropDownValue = 'Male';

  FormMode _formMode = FormMode.LOGIN;
  bool _isLoading = false;
  bool _autoValidate = false;

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

  Widget _showUsernameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Username',
            icon: new Icon(
              Icons.person,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
        onSaved: (value) => _username = value,
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showPhoneNumberInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        maxLength: 10,
        keyboardType: TextInputType.phone,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Phone',
            icon: new Icon(
              Icons.phone_android,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Phone can\'t be empty' : null,
        onSaved: (value) => _phone = value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showDobInput() {
    final format = DateFormat("yyyy-MM-dd");
    return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Enter DOB'),
              DateTimeField(
                style: TextStyle(color: Colors.black),
                initialValue: dob,
                format: format,
                onShowPicker: (context, currentValue) async {
                  dob = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  return dob;
                  //return Future<DateTime>.value(dob);
                },
              ),
            ]));
  }

  Widget _showGenderInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: DropdownButton<String>(
        hint: Text('Select Gender'),
        value: dropDownValue,
        icon: Icon(Icons.person, color: Colors.grey),
        iconSize: 22,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) {
          setState(() {
            dropDownValue = newValue;
          });
        },
        items: <String>['Male', 'Female', 'Other']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _showPrimaryButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: new MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0)),
          elevation: 5.0,
          minWidth: 200.0,
          height: 42.0,
          color: Colors.blue,
          child: _formMode == FormMode.LOGIN
              ? new Text("Login",
                  style: new TextStyle(fontSize: 20.0, color: Colors.white))
              : new Text('SignUp',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed: () {
            _formMode == FormMode.LOGIN
                ? _validateAndLogin()
                : _validateAndSignup();
          },
        ));
  }

  Widget _showSecondaryButton() {
    return FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
              style:
                  new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  Widget _showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Email Confirmation"),
          content: new Text(
              "We've sent a verification email. Please verify your account and login again."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _validateAndLogin() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      QueryResult result = await login(_email, _password);
      //String token = response['tokenAuth']['token'];
      print("----------------------------Back with response-----------------");
      if (result.hasErrors) {
        print("Sorry bruh...");
        toast(result.errors[0].toString());
      } else {
        String token = result.data.data['tokenAuth']['token'];
        token = 'JWT ' + token;
        Parameter tokenParameter = new Parameter();
        tokenParameter.parameterName = 'Token';
        tokenParameter.parameterValue = token;
        print(tokenParameter.parameterValue);
        print(
            "----------------------------Trying to store token-----------------");

        await DBProvider.db.newParameter(tokenParameter);

        print(
            "----------------------------Token Stored successfully-----------------");

        print(
            "----------------------------Trying to get token-----------------");

        dynamic tok = await DBProvider.db.getParameter('Token');
        print(tok.parameterValue);

        print(
            "----------------------------Got Token successfully-----------------");

        setState(() {
          _isLoading = false;
        });

        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new HomePage(),
        );
        Navigator.of(context)
            .pushAndRemoveUntil(route, (Route<dynamic> route) => false);
      }
    }
  }

  _validateAndSignup() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    if (_validateAndSave()) {
      print("abc");

      print(_email);
      print(_password);
      print(_username);
      print(dropDownValue);
      print(_phone);
      print("***///////////////////////////////////////////**********");

      var formatter = new DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(dob);
      int gender;
      if (dropDownValue == 'Male') {
        gender = 1;
      } else if (dropDownValue == 'Female') {
        gender = 0;
      } else {
        gender = 2;
      }

      print("****************************************");
      print(gender);
      print(formatted);
      print(int.parse(_phone));
      int x = int.parse(_phone);
      QueryResult result =
          await signup(_username, _email, _password, formatted, x, gender);

      print("----------------------------Back with response-----------------");
      if (result.hasErrors) {
        print("Sorry bruh...");
        toast(result.errors[0].toString());
      } else {
        String username = result.data.data['createUser']['user']['username'];
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
            "----------------------------Trying to get Username-----------------");

        dynamic use = await DBProvider.db.getParameter('Username');
        print(use.parameterValue);

        print(
            "----------------------------Got Username successfully-----------------");

        setState(() {
          _isLoading = false;
        });

        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new LandingPage(),
        );
        Navigator.of(context)
            .pushAndRemoveUntil(route, (Route<dynamic> route) => false);

        _showDialog();
      }
    }
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: _formMode == FormMode.LOGIN
                ? new ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      _showEmailInput(),
                      _showPasswordInput(),
                      _showPrimaryButton(),
                      _showSecondaryButton(),
                      _showErrorMessage(),
                    ],
                  )
                : new ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      _showUsernameInput(),
                      _showEmailInput(),
                      _showPasswordInput(),
                      _showDobInput(),
                      _showPhoneNumberInput(),
                      _showGenderInput(),
                      _showPrimaryButton(),
                      _showSecondaryButton(),
                      _showErrorMessage(),
                    ],
                  )));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: _formMode == FormMode.LOGIN
              ? new Text("Login")
              : new Text("SignUp"),
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
            _showCircularProgress(),
          ],
        ));
  }
}
