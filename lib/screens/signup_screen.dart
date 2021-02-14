import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/user_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {

          if(model.isLoading)
            return Center(child: CircularProgressIndicator());
          

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nome completo"
                  ),
                  controller: _nameController,
                  validator: (text) {
                    if(text.isEmpty)
                      return "Nome inválido!";
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "E-mail"
                  ),
                  controller: _emailController,
                  validator: (text) {
                    if(text.isEmpty || !text.contains('@'))
                      return "Email inválido!";
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Endereço",
                  ),
                  controller: _addressController,
                  validator: (text) {
                    if(text.isEmpty)
                      return "Endereço inválido!";
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Senha",
                  ),
                  obscureText: true,
                  controller: _passController,
                  validator: (text) {
                    if(text.isEmpty || text.length <= 6)
                      return "Escolha uma senha maior!";
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text("Cadastrar", style: TextStyle(fontSize: 18.0)),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if(_formKey.currentState.validate()) {

                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "address": _addressController.text
                        };

                        model.signUp(
                          userData: userData,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail
                        );
                      }
                    },
                  )
                )
              ],
            ),
          );
        },
      )
    );
  }

  void _onSuccess() {

  }

  void _onFail() {

  }

}