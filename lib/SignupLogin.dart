import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool rememberMe = prefs.getBool('rememberMe') ?? false;
  runApp(MyApp(rememberMe: rememberMe));
}

class MyApp extends StatelessWidget {
  final bool rememberMe;

  MyApp({required this.rememberMe});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: rememberMe ? MainPage() : LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('rememberMe', _rememberMe);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Form'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            CheckboxListTile(
              title: Text("Remember me"),
              value: _rememberMe,
              onChanged: (newValue) {
                setState(() {
                  _rememberMe = newValue ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Text('Welcome to the Main Page!'),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Login Form'),
//         ),
//         body: LoginForm(),
//       ),
//     );
//   }
// }
//
// class LoginForm extends StatefulWidget {
//   @override
//   _LoginFormState createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<LoginForm> {
//   final _formKey = GlobalKey<FormState>();
//   bool _rememberMe = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Email'),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your email';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Password'),
//             obscureText: true,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your password';
//               }
//               return null;
//             },
//           ),
//           CheckboxListTile(
//             title: Text("Remember me"),
//             value: _rememberMe,
//             onChanged: (newValue) {
//               setState(() {
//                 _rememberMe = newValue;
//               });
//             },
//             controlAffinity: ListTileControlAffinity.leading,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_formKey.currentState.validate()) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Processing Data')),
//                 );
//               }
//             },
//             child: Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
// }
