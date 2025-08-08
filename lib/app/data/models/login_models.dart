part of "models.dart";

class LoginModel {
  final String token;

  LoginModel({required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(token: json['token']);
  }

  @override
  List<Object> get props => [token];
}
