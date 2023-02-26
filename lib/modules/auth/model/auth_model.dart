class AuthModel {
  String? nome;
  String? email;
  String? senha;

  AuthModel({this.nome, this.email, this.senha});

  AuthModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['nome'] = nome;
    data['email'] = email;
    data['senha'] = senha;
    return data;
  }
}