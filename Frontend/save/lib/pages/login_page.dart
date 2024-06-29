import 'package:flutter/material.dart';
import 'package:save/models/login_request_model.dart';
import 'package:save/pages/register_page.dart';
import 'package:save/services/api_services.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:save/config.dart'; // Ensure you have a config file that defines appName

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/16.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Overlaying Container with text and logo
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 16.0), // Optional padding to separate text from fields
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                _entryField("Username", (value) => username = value),
                const SizedBox(height: 10),
                _entryField("Password", (value) => password = value, isPassword: true),
                const SizedBox(height: 20),
                _submitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryField(String title, Function(String) onChanged,
      {bool isPassword = false}) {
    return TextFormField(
      obscureText: isPassword ? hidePassword : false,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: title,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
              )
            : null,
      ),
    );
  }

  Widget _submitButton() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (validateAndSave()) {
              setState(() {
                isAPIcallProcess = true;
              });
              LoginRequestModel model = LoginRequestModel(
                username: username!,
                password: password!,
              );
              APIService.login(model).then((response) {
                setState(() {
                  isAPIcallProcess = false;
                });
                if (response) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                } else {
                  FormHelper.showSimpleAlertDialog(
                    context,
                    Config.appName,
                    "Username/Password Salah",
                    "OK",
                    () {
                      Navigator.pop(context);
                    },
                  );
                }
              });
            } else {
              FormHelper.showSimpleAlertDialog(
                context,
                Config.appName,
                "Semua field harus diisi",
                "OK",
                () {
                  Navigator.pop(context);
                },
              );
            }
          },
          child: const Text("Login"),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => RegisterPage()));
          },
          child: Text(
            "Belum punya akun? Daftar di sini",
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
