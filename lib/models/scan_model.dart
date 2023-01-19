import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';
import 'dart:convert';

/// Este seria el modelo que se usara para comunicar el tema de los Scans

class ScanModel {
  ScanModel({
    this.id,
    this.tipus,
    required this.valor,
  }) {
    if (this.valor.contains('http')) {
      this.tipus = 'http';
    } else {
      this.tipus = 'geo';
    }
  }

  int? id;
  String? tipus;
  String valor;

  LatLng getLating() {
    final latlng = this.valor.substring(4).split(',');
    final latitude = double.parse(latlng[0]);
    final longitude = double.parse(latlng[1]);

    return LatLng(latitude, longitude);
  }

  factory ScanModel.fromRawJson(String str) =>
      ScanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipus: json["tipus"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipus": tipus,
        "valor": valor,
      };
}
