class ErrorResponse{
  String? status;
  String? message;

  ErrorResponse({
     this.status,
     this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    status: json["status"],
    message: json["status_message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_message": message,
  };
}