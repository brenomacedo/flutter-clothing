import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Nome completo"
              ),
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
                    
                  }
                },
              )
            )
          ],
        ),
      ),
    );
  }
}