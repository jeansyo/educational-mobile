// To parse this JSON data, do
//
//     final pregunta = preguntaFromJson(jsonString);

import 'dart:convert';

class Preguntas {
  List<Pregunta> items = [];
  Preguntas();
  Preguntas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final cita = Pregunta.fromJson(item);
        items.add(cita);
      }
    }
  }
}

Pregunta preguntaFromJson(String str) => Pregunta.fromJson(json.decode(str));
String preguntaToJson(Pregunta data) => json.encode(data.toJson());

class Pregunta {
    Pregunta({
        this.firstanswer,
        this.secondanswer,
        this.thirdanswer,
        this.question,
        this.id,
    });

    String? firstanswer;
    String? secondanswer;
    String? thirdanswer;
    String? question;
    int? id;

    factory Pregunta.fromJson(Map<String, dynamic> json) => Pregunta(
        firstanswer: json["firstanswer"],
        secondanswer: json["secondanswer"],
        thirdanswer: json["thirdanswer"],
        question: json["question"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "firstanswer": firstanswer,
        "secondanswer": secondanswer,
        "thirdanswer": thirdanswer,
        "question": question,
        "id": id,
    };
}
