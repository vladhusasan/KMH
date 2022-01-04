import 'package:flutter/material.dart';

import 'API_conector_user.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {
  User futureUser;
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType.login; // our default setting is to login, and we should switch to creating an account when the user chooses to
  @override
  void GetUser(String email,String pass) {
    Server.fetchUser('matragunamihai97@gmail.com','qwaszx').then((user) {
     //Server.fetchUser(_email,_password).then((user) {
      setState(() {
        futureUser = user as User;
        if(futureUser.errorCode=='1')
        _ackAlert(context,"Parola este gresita");
        else {
          if (futureUser.errorCode == '2')
            _ackAlert(context, "Userul este gresit");
          else {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(user: futureUser)));

          }
        }
      });
    });
  }
  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange () async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //appBar: _buildBar(context),
      body: new Container(
        color: Color.fromARGB(250, 33, 156, 210,),
        padding: EdgeInsets.all(16.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor:Color.fromARGB(255,33, 156, 210,),
    );
  }

  Widget _buildTextFields() {
    return new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
                padding:  const EdgeInsets.all(20.0),
                child: Image.network('https://servuspress.ro/wp-content/uploads/2020/09/116464958_153437009660008_3708669460152869763_n.jpg'),
                decoration: new BoxDecoration(
                color: Color.fromARGB(255,33, 156, 210,),
              ),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              padding:  const EdgeInsets.all(10.0),
              child: new TextField(
                controller: _emailFilter,
                decoration: new InputDecoration(
                    labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(1)),
                ),
              ),
            ),
            new Container(
              padding:  const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: new TextField(
                controller: _passwordFilter,
                decoration: new InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(1)),
                ),
                obscureText: true,
              ),
            )
          ],
        ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new FlatButton(
              child: new Text('Login',style: TextStyle(color: Colors.white.withOpacity(1))),
              onPressed:_loginPressed,
            ),
            new FlatButton(
              child: new Text('Nu ai cont?',style: TextStyle(color: Colors.white.withOpacity(1))),
              onPressed: _formChange,
            ),
            new FlatButton(
              child: new Text('Mi-am uitat parola',style: TextStyle(color: Colors.white.withOpacity(1))),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            new FlatButton(
              child: new Text('Creaza cont',style: TextStyle(color: Colors.white.withOpacity(1))),
              onPressed: _createAccountPressed,
            ),
            new FlatButton(
              child: new Text('Ai deja cont?',style: TextStyle(color: Colors.white.withOpacity(1))),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed () async{
    _emailListen();
    _passwordListen();
    GetUser(_email,_password);
    }

  void _createAccountPressed () {
    print('The user wants to create an accoutn with $_email and $_password');

  }

  void _passwordReset () {
    print("The user wants a password reset request sent to $_email");
  }

  Future<void> _ackAlert(BuildContext context,String errorN) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(errorN),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}