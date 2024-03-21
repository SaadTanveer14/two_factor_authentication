class BackupCodeModel {
  String? status;
  String? statusMessage;
  List<CodeList>? codeList;

  BackupCodeModel({this.status, this.statusMessage, this.codeList});

  BackupCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    if (json['list'] != null) {
      codeList = <CodeList>[];
      json['list'].forEach((v) {
        codeList!.add(new CodeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    if (this.codeList != null) {
      data['list'] = this.codeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CodeList {
  int? code;

  CodeList({this.code});

  CodeList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}