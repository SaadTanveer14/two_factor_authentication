class SuccessResponse{
  String? status;
  String? message;

  SuccessResponse({
    this.status,
    this.message,
  });

  factory SuccessResponse.fromJson(Map<String, dynamic> json) => SuccessResponse(
    status: json["status"],
    message: json["status_message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_message": message,
  };
}