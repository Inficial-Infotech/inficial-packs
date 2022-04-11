import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
// Services:
import 'package:packs/utils/services/authentication_manager.dart';
import 'package:packs/modules/home/screens/home_screen.dart';
// Widgets:
import 'package:packs/widgets/components/button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final AuthenticationManager _auth = AuthenticationManager();
  bool showSpinner = false;
  String email = '';
  String password = '';

  void createUser() async {
    final result = await _auth.convertUser(email: email, password: password);
    // ignore: unnecessary_null_comparison
    if (result == null) {
      print('ERROR [createUser]');
      return;
    }

    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 48.0,
              ),
              CupertinoTextField(
                keyboardType: TextInputType.emailAddress,
                placeholder: 'Email',
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 48.0,
              ),
              CupertinoTextField(
                placeholder: 'Password',
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 48.0,
              ),
              CupertinoButton.filled(
                child: Text('SIGN UP'),
                onPressed: () {
                  createUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
