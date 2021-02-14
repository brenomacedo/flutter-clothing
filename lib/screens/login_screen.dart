import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          FlatButton(
            child: Text("Criar conta", style: TextStyle(fontSize: 15.0, color: Colors.white)),
            onPressed: () {

            }
          )
        ]
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "E-mail"
              ),
              validator: (text) {
                if(text.isEmpty || !text.contains('@'))
                  return "Email inválido!";
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Senha",
              ),
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if(text.isEmpty || text.length <= 6)
                  return "Escolha uma senha maior!";
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text("Esqueci minha senha", textAlign: TextAlign.right),
                padding: EdgeInsets.zero,
                onPressed: () {

                },
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                child: Text("Entrar", style: TextStyle(fontSize: 18.0)),
                textColor: Theme.of(context).primaryColor,
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