class LoginModel {
  String? jwt;
  User? user;

  LoginModel({this.jwt, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? documentId;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? nim;
  String? name;
  String? birthDate;
  String? password;


  User({
    this.id,
    this.documentId,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.nim,
    this.name,
    this.birthDate,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentId = json['documentId'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    nim = json['nim'];
    name = json['name'];
    birthDate = json['birthDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.username != null) data['username'] = this.username;
    if (this.email != null) data['email'] = this.email;
    if (this.password != null) data['password'] = this.password;
    if (this.nim != null) data['nim'] = this.nim;
    if (this.name != null) data['name'] = this.name;
    if (this.birthDate != null) data['birthDate'] = this.birthDate;
    return data;
  }
}
