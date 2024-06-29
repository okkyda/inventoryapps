import 'package:flutter/material.dart';
import 'package:save/models/register_request_model.dart';
import 'package:save/services/api_services.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:save/config.dart'; // Ensure you have a config file that defines appName

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: ProgressHUD(
          child: SingleChildScrollView(
            child: Form(
              key: globalFormKey,
              child: _registerUI(context),
            ),
          ),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return Column(
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
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/16.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                _entryField("Username", (value) => username = value),
                const SizedBox(height: 10),
                _entryField("Email", (value) => email = value),
                const SizedBox(height: 10),
                _entryField("Password", (value) => password = value, isPassword: true),
                const SizedBox(height: 20),
                _registerButton(),
              ],
            ),
          ),
        ),
      ],
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

  Widget _registerButton() {
    return ElevatedButton(
      onPressed: () {
        if (validateAndSave()) {
          setState(() {
            isAPIcallProcess = true;
          });
          RegisterRequestModel model = RegisterRequestModel(
            username: username!,
            email: email!,
            password: password!,
          );
          APIService.register(model).then((response) {
            setState(() {
              isAPIcallProcess = false;
            });
            if (response.data != null) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Success"),
                    content: Text("Register Berhasil, Silahkan Login"),
                    actions: [
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          ); // Navigate to login page
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              FormHelper.showSimpleAlertDialog(
                context,
                Config.appName,
                response.message,
                "OK",
                () {
                  Navigator.pop(context);
                },
              );
            }
          });
        }
      },
      child: const Text("Register"),
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
