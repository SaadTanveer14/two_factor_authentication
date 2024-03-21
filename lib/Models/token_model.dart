class TokenModel {
  String status;
  String statusMessage;
  DateTime datetime;
  int token;

  TokenModel({
    required this.status,
    required this.statusMessage,
    required this.datetime,
    required this.token,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    status: json["status"],
    statusMessage: json["status_message"],
    datetime: DateTime.parse(json["datetime"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_message": statusMessage,
    "datetime": datetime.toIso8601String(),
    "token": token,
  };
}