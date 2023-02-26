class ContactModel {
  int? id;
  String? nome;
  String? cpf;
  String? sexo;
  String? telefone;
  String? cep;
  String? endereco;
  String? uf;
  String? complemento;
  String? latitude;
  String? longitude;

  ContactModel(
      {
      this.id,
      this.nome,
      this.cpf,
      this.sexo,
      this.telefone,
      this.cep,
      this.endereco,
      this.uf,
      this.complemento,
      this.latitude,
      this.longitude});

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cpf = json['cpf'];
    sexo = json['sexo'];
    telefone = json['telefone'];
    cep = json['cep'];
    endereco = json['endereco'];
    uf = json['uf'];
    complemento = json['complemento'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['nome'] = nome;
    data['cpf'] = cpf;
    data['sexo'] = sexo;
    data['telefone'] = telefone;
    data['cep'] = cep;
    data['endereco'] = endereco;
    data['uf'] = uf;
    data['complemento'] = complemento;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}