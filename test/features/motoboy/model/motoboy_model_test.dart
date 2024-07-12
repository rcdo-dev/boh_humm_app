// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

class MotoboyModel {
  final int? mot_id;
  final String? mot_name;
  final String? mot_email;
  final Uint8List? mot_image;

  MotoboyModel({
    this.mot_id,
    this.mot_name,
    this.mot_email,
    this.mot_image,
  });

  Map<String, Object?> toMap() {
    var map = <String, Object?>{};
    map['mot_id'] = mot_id;
    map['mot_name'] = mot_name;
    map['mot_email'] = mot_email;
    map['mot_image'] = mot_image;
    return map;
  }

  factory MotoboyModel.fromMap(Map<String, Object?> map) {
    return MotoboyModel(
      mot_id: int.tryParse(map['mot_id'].toString()),
      mot_name: map['mot_name'].toString(),
      mot_email: map['mot_email'].toString(),
      mot_image: map['mot_image'] as Uint8List,
    );
  }
}

void main() {
  MotoboyModel motoboy = MotoboyModel(
    mot_id: 1,
    mot_name: 'Ricardo',
    mot_email: 'rcdo.dev@gmail.com',
    mot_image: Uint8List.fromList([0, 1, 2, 3, 4]),
  );

  var map = motoboy.toMap();

  var motoboyData = MotoboyModel.fromMap(map);

  group('MotoboyModel object conversion', () {
    test('Must convert a MotoboyModel object into a map.', () {
      expect(map, isA<Map<String, Object?>>());
    });

    test('Must convert a map into a MotoboyModel object.', () {
      expect(motoboyData, isA<MotoboyModel>());
    });
  });
}
