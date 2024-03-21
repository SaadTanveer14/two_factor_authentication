class LoginResponseModel {
  String status;
  String statusMessage;
  List<ListElement> list;

  LoginResponseModel({
    required this.status,
    required this.statusMessage,
    required this.list,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    statusMessage: json["status_message"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_message": statusMessage,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  String userId;
  String name;
  String token;

  ListElement({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    userId: json["user_id"],
    name: json["name"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "token": token,
  };
}
