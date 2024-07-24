import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

class MotoboyPage extends StatelessWidget {
  const MotoboyPage({super.key});

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

void main() {
  testWidgets('motoboy page ...', (tester) async {
    await tester.pumpWidget(MaterialApp(home: MotoboyPage()));

    final text = find.byType(Text);
    expect(text, findsWidgets);

    debugDumpRenderTree();
  });
}
