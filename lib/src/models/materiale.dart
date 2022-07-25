// To parse this JSON data, do
//
//     final material = materialFromJson(jsonString);

import 'dart:convert';

class Materiales {
  List<Materiale> items = [];
  Materiales();
  Materiales.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final cita = Materiale.fromJson(item);
        items.add(cita);
      }
    }
  }
}

Materiale materialeFromJson(String str) => Materiale.fromJson(json.decode(str));

String materialeToJson(Materiale data) => json.encode(data.toJson());

class Materiale {
    Materiale({
        this.idl,
        this.name,
        this.filename,
        this.link,
        this.type,
        this.date,
        this.id,
        this.courseName,
        this.courseId,
        this.descargado,
        this.esReciente
    });
    int? idl;
    String? name;
    String? filename;
    String? link;
    int? type;
    String? date;
    int? id;
    String? courseName;
    int? courseId;
    int? descargado;
    int? esReciente;
    factory Materiale.fromJson(Map<String, dynamic> json) => Materiale(
        idl:json["idl"],
        name: json["name"],
        filename: json["filename"],
        link: json["link"],
        type: json["type"],
        date: json["date"],
        id: json["id"],
        courseName: json["courseName"],
        courseId: json["courseID"],
        descargado: json["descargado"],
        esReciente: json["esReciente"]
    );

    Map<String, dynamic> toJson() => {
        "idl":idl,
        "name": name,
        "filename": filename,
        "link": link,
        "type": type,
        "date": date,
        "id": id,
        "courseName": courseName,
        "courseID": courseId,
        "descargado":descargado,
        "esReciente":esReciente
    };
}
