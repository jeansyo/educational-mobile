// To parse this JSON data, do
//
//     final courses = coursesFromJson(jsonString);

import 'dart:convert';

class Cursos {
  List<Curso> items = [];
  Cursos();
  Cursos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final cita = Curso.fromJson(item);
        items.add(cita);
      }
    }
  }
}

Curso cursoFromJson(String str) => Curso.fromJson(json.decode(str));
String cursoToJson(Curso data) => json.encode(data.toJson());

class Curso {
    Curso({
        this.idl,
        this.id,
        this.name,
        this.students,
        this.classname,
        this.recommended
        
    });

    int? idl;
    int? id;
    String? name;
    int? students;
    String? classname;
    String? recommended;

    factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        idl: json["idl"],
        id: json["id"],
        name: json["name"],
        students: json["students"],
        classname: json["classname"],
        recommended: json["recommended"],
    );

    Map<String, dynamic> toJson() => {
        "idl":idl,
        "id": id,
        "name": name,
        "students": students,
        "classname": classname,
        "recommended": recommended
    };
}
