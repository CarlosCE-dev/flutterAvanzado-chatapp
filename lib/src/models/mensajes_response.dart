// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromJson(jsonString);

import 'dart:convert';

MensajesResponse mensajesResponseFromJson(String str) => MensajesResponse.fromJson(json.decode(str));

String mensajesResponseToJson(MensajesResponse data) => json.encode(data.toJson());

class MensajesResponse {
    MensajesResponse({
        this.ok,
        this.data,
    });

    bool ok;
    List<Mensaje> data;

    factory MensajesResponse.fromJson(Map<String, dynamic> json) => MensajesResponse(
        ok: json["ok"],
        data: List<Mensaje>.from(json["data"].map((x) => Mensaje.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Mensaje {
    Mensaje({
        this.de,
        this.para,
        this.mensaje,
        this.createdAt,
        this.updatedAt,
    });

    String de;
    String para;
    String mensaje;
    DateTime createdAt;
    DateTime updatedAt;

    factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
