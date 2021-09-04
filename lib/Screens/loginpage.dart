import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Validators validators = new Validators();
  bool isadmin = false;
  Future<String> _authUser(data) async {
    String result = await login.login(data.name, data.password);

    if (result == 'start') {
      return null;
    } else {
      return result;
    }
  }

  Future<String> _authRegister(data) async {
    String result = await login.register(data.name, data.password, 'customer');

    if (result == 'start1') {
      // bcart.saveuid();
      createuserapi(login.uid, data.name, data.password);
      return 'Please Verify the E-Mail';
    } else {
      return result;
    }
  }

  // ignore: missing_return
  Future<String> _recoverPassword(String name) async {
    String result = await login.forgot(name);

    if (result == 'start') {
      return null;
    } else {
      return result;
    }
  }

  Response response;
  String serverurl = 'http://127.0.0.1:8000';

  var dio = Dio();
  createuserapi(uid, username, password) async {
    Map<String, dynamic> map = {
      'userid': uid,
      'username': username,
      'password': password,
    };
    print(map);
    // response = await dio.get(serverurl + '/users/');
    var response = await dio.post(serverurl + '/users/', data: map);
    print(response.data.toString());

    if (response.data['response']['data'] == 'success') {
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong!")));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'WoodKart',
      logo: 'lib/src/assets/images/launcher_logo.png',
      onLogin: _authUser,
      emailValidator: (value) {
        if (validators.isValidEmail(value) == true) {
          return null;
        } else {
          return 'Enter vaild E-Mail';
        }
      },
      passwordValidator: (value) {
        if (validators.isPassword(value) == true) {
          return null;
        } else {
          return 'Enter vaild Password';
        }
      },
      loginAfterSignUp: true,
      onSignup: _authRegister,
      footer: 'created by deepak',
      hideForgotPasswordButton: false,
      onSubmitAnimationCompleted: () {
        Navigator.pushReplacementNamed(context, '/dashboard');
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}

Login login = Login();

class Login {
  var uid;
  Future<String> login(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User firebaseUser = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      String uid = firebaseUser.uid;
      var user = auth.currentUser;
      await user.reload();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (user.emailVerified) {
        await prefs.setString('uid', uid);
        return 'start';
      } else {
        return 'Email Not Verified';
      }
    } catch (e) {
      print(e.toString());
      if (e.toString() ==
          '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
        return 'Account Not Registered or Enter Correct E-Mail Address';
      } else if (e.toString() ==
          '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
        return 'Wrong Password';
      }
      return e.toString();
    }
  }

  Future<String> register(
      String email, String password, String typeAccount) async {
    var username = email.split('@')[0];
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      var user1 = firebaseAuth.currentUser;
      user1.sendEmailVerification();
      uid = user.uid;
      return 'start1';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> forgot(String email) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.sendPasswordResetEmail(email: email);
      return 'start';
    } catch (e) {
      return e.toString();
    }
  }
}
