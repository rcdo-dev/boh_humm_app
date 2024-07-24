import 'package:flutter/material.dart';

class MotoboyPage extends StatelessWidget {
  const MotoboyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastre-se'),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Icon(
              Icons.camera_alt_outlined,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          CircleAvatar(
            child: Icon(Icons.person),
          ),
          TextFormField(),
          TextFormField(),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Cadastrar',
            ),
          )
        ],
      ),
    );
  }
}
