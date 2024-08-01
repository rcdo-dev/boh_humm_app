import 'package:boh_humm/features/motoboy/widgets/picture/error_picture.dart';
import 'package:boh_humm/features/motoboy/widgets/picture/initial_picture.dart';
import 'package:boh_humm/features/motoboy/widgets/picture/loaded_picture.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boh_humm/features/motoboy/blocs/motoboy/motoboy_bloc.dart';
import 'package:boh_humm/features/motoboy/blocs/motoboy/motoboy_state.dart';
import 'package:boh_humm/features/motoboy/blocs/picture/picture_bloc.dart';
import 'package:boh_humm/features/motoboy/blocs/picture/picture_event.dart';
import 'package:boh_humm/features/motoboy/blocs/picture/picture_state.dart';
import 'package:boh_humm/features/motoboy/controller/motoboy_controller.dart';
import 'package:boh_humm/shared/widgets/app_button.dart';
import 'package:boh_humm/shared/widgets/app_text_form_field.dart';

class MotoboyPage extends StatelessWidget {
  final MotoboyController controller;

  MotoboyPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Modular.get<MotoboyBloc>();
    final blocPicture = Modular.get<PictureBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastre-se'),
        actions: [
          AppButton(
            onPressed: () {
              blocPicture.add(GetPictureCameraEvent());
            },
            child: Icon(
              Icons.camera_alt_outlined,
            ),
            width: 80,
          ),
        ],
      ),
      body: BlocBuilder<MotoboyBloc, MotoboyState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is InitialMotoboy) {
            return SingleChildScrollView(
              child: SizedBox(
                height: size.height / 1.3,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    BlocBuilder<PictureBloc, PictureState>(
                      bloc: blocPicture,
                      builder: (context, state) {
                        if (state is InitialPictureState) {
                          return InitialPicture();
                        } else if (state is LoadedPictureState) {
                          return LoadedPicture(
                            state: state,
                          );
                        } else if (state is ErrorPictureState) {
                          return ErrorPicture(
                            state: state,
                          );
                        }
                        return Center(
                          child: Text('Deu ruim'),
                        );
                      },
                    ),
                    Column(
                      children: <Widget>[
                        AppTextFormField(
                          labelText: 'Nome',
                          controller: controller.nameController,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        AppTextFormField(
                          labelText: 'E-mail',
                          controller: controller.emailController,
                        ),
                      ],
                    ),
                    AppButton(
                      child: Text('Cadastrar'),
                      onPressed: () {
                        // bloc.add(
                        //   RegisterMotoboy(
                        //     motoboy: MotoboyModel(
                        //       mot_name: controller.nameController.text,
                        //       mot_email: controller.emailController.text,
                        //     ),
                        //   ),
                        // );
                      },
                      width: 220,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is LoadedMotoboy) {
            return Center(
              child: ListView.builder(
                itemCount: state.motoboys?.length,
                itemBuilder: (context, index) {
                  return Text(
                    state.motoboys?[index]['mot_name'],
                  );
                },
              ),
            );
          } else {
            return Text('Não deu!');
          }
        },
      ),
    );
  }
}
