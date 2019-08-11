import 'package:flutter/material.dart';
import 'package:punk_picks/provider.dart';

enum FormType { login, register }

class EmailValidator {
  static String validate(String value) {
    return value.isEmpty ? "Email can't be empty" : null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    return value.isEmpty ? "Password can't be empty" : null;
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  String _email, _password;
  FormType _formType = FormType.login;

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        if (_formType == FormType.login) {
          String userId = await auth.signInWithEmailAndPassword(
            _email,
            _password,
          );

          print('Signed in $userId');
        } else {
          String userId = await auth.createUserWithEmailAndPassword(
            _email,
            _password,
          );

          print('Registered in $userId');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void switchFormState(String state) {
    formKey.currentState.reset();

    if (state == 'register') {
      setState(() {
        _formType = FormType.register;
      });
    } else {
      setState(() {
        _formType = FormType.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page'),
      ),
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        validator: EmailValidator.validate,
        decoration: InputDecoration(labelText: 'Email'),
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        validator: PasswordValidator.validate,
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          child: Text('Login'),
          color: Colors.blueAccent,
          onPressed: submit,
        ),
        FlatButton(
          child: Text('Register Account'),
          color: Colors.teal,
          onPressed: () {
            switchFormState('register');
          },
        ),
        Divider(
          height: 50.0,
        ),
      ];
    } else {
      return [
        RaisedButton(
          child: Text('Create Account'),
          color: Colors.blueAccent,
          onPressed: submit,
        ),
        FlatButton(
          child: Text('Go to Login'),
          color: Colors.teal,
          onPressed: () {
            switchFormState('login');
          },
        )
      ];
    }
  }
}