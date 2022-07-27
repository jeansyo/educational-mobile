// To parse this JSON data, do
//
//     final evaluacion = evaluacionFromJson(jsonString);

import 'dart:convert';


class Evaluaciones {
  List<Evaluacion> items = [];
  Evaluaciones();
  Evaluaciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final cita = Evaluacion.fromJson(item);
        items.add(cita);
      }
    }
  }
}


Evaluacion evaluacionFromJson(String str) => Evaluacion.fromJson(json.decode(str));

String evaluacionToJson(Evaluacion data) => json.encode(data.toJson());

class Evaluacion {
    Evaluacion({
        this.id,
        this.course,
        this.start,
        this.end,
        this.status,
        this.score
    });

    int? id;
    int? course;
    String? start;
    String? end;
    int? status;
    int? score;

    factory Evaluacion.fromJson(Map<String, dynamic> json) => Evaluacion(
        id: json["id"],
        course: json["course"],
        start: json["start"],
        end: json["end"],
        status: json["status"],
        score: json["score"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "course": course,
        "start": start,
        "end": end,
        "status": status,
        "score": score
    };
}
