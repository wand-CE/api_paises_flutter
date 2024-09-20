import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_countries_flutter/controllers/operations_firebase_controller.dart';

// import 'forgotPassPage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final OperationsFirebaseController _operationsFirebaseController = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text('Faça seu Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 200, 30, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('E-mail'),
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo email vazio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Senha'),
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo senha vazio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> loginData =
                          await _operationsFirebaseController.loginUser(
                              emailController.text, passwordController.text);
                      Get.showSnackbar(
                        GetSnackBar(
                          messageText: Text(
                            "${loginData["message"]}",
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 5),
                        ),
                      );
                      if (loginData["isLogged"]) {
                        Get.offAllNamed("/homePage");
                      }
                    }
                  },
                  child: Text(
                    'Entrar',
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                  ),
                ),
                TextButton(
                    onPressed: () => Get.toNamed('/registerPage'),
                    child: Text('Criar uma nova conta')),
                // TextButton(
                //     onPressed: () => (), child: Text('Esqueci minha senha'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
