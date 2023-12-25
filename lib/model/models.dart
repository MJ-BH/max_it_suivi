// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
    int code;
    bool state;
    String message;
    Data data;
    int lastUpdate;

    DataModel({
        required this.code,
        required this.state,
        required this.message,
        required this.data,
        required this.lastUpdate,
    });

    factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        code: json["code"],
        state: json["state"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        lastUpdate: json["last_update"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "state": state,
        "message": message,
        "data": data.toJson(),
        "last_update": lastUpdate,
    };
}

class Data {
    List<Departement> departement;

    Data({
        required this.departement,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        departement: List<Departement>.from(json["departement"].map((x) => Departement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "departement": List<dynamic>.from(departement.map((x) => x.toJson())),
    };
}

class Departement {
    int progress;
    String name;
    List<Task> task;

    Departement({
        required this.progress,
        required this.name,
        required this.task,
    });

    factory Departement.fromJson(Map<String, dynamic> json) => Departement(
        progress: json["progress"],
        name: json["name"],
        task: List<Task>.from(json["task"].map((x) => Task.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "progress": progress,
        "name": name,
        "task": List<dynamic>.from(task.map((x) => x.toJson())),
    };
}

class Task {
    int progress;
    String description;

    Task({
        required this.progress,
        required this.description,
    });

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        progress: json["progress"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "progress": progress,
        "description": description,
    };
}


// To parse this JSON data, do
//
//     final globalProgress = globalProgressFromJson(jsonString);


GlobalProgress globalProgressFromJson(String str) => GlobalProgress.fromJson(json.decode(str));

String globalProgressToJson(GlobalProgress data) => json.encode(data.toJson());

class GlobalProgress {
    double  progress;
    int dateLancement;

    GlobalProgress({
        required this.progress,
        required this.dateLancement,
    });

    factory GlobalProgress.fromJson(Map<String, dynamic> json) => GlobalProgress(
        progress: json["progress"],
        dateLancement: json["date_lancement"],
    );

    Map<String, dynamic> toJson() => {
        "progress": progress,
        "date_lancement": dateLancement,
    };
}
