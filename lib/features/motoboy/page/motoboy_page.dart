import 'package:boh_humm/shared/widgets/app_button.dart';
import 'package:boh_humm/shared/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class MotoboyPage extends StatelessWidget {
  const MotoboyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastre-se'),
        actions: [
          AppButton(
            onPressed: () {},
            child: Icon(
              Icons.camera_alt_outlined,
            ),
            width: 80,
          ),
        ],
      ),
      body: Container(
        height: size.height / 1.3,
        width: double.infinity,
        color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              color: Colors.red,
              height: size.height / 4.5,
              child: CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 100,
                ),
                maxRadius: 100,
              ),
            ),
            Column(
              children: <Widget>[
                AppTextFormField(
                  labelText: 'Nome',
                ),
                SizedBox(
                  height: 18,
                ),
                AppTextFormField(
                  labelText: 'E-mail',
                ),
              ],
            ),
            AppButton(
              child: Text('Cadastrar'),
              onPressed: () {},
              width: 220,
            ),
          ],
        ),
      ),
    );
  }
}
