import 'package:firebase_database/firebase_database.dart';

class Medico {
  String key = "";
  String nome = "";
  String email = "";
  String senha = "";
  String especialidade = "";

  Medico(String s, {this.nome, this.email, this.senha, this.especialidade});

  Medico.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        nome = snapshot.value['nome'],
        email = snapshot.value['email'],
        senha = snapshot.value['senha'],
        especialidade = snapshot.value['especialidade'];

  toJason() {
    return {
      "nome": nome,
      "email": email,
      "senha": senha,
      "especialidade": especialidade,
    };
  }
}

//Medico userMed = new Medico();
