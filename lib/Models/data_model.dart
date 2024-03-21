class DataModel {
  String status;
  String message;
  List<ListElement> list;

  DataModel({
    required this.status,
    required this.message,
    required this.list,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    status: json["status"],
    message: json["status_message"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_message": message,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  String userId;
  String name;

  ListElement({
    required this.userId,
    required this.name,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    userId: json["user_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
  };
}