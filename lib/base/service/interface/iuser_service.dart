import 'package:flutter_app/base/models/dto/endereco/endereco_dto.dart';
import 'package:flutter_app/base/models/smartStorege/user/user.dart';

abstract class IUserService {
  Future<User?> login(String userName, String passWord);
  Future<Endereco?> carregaCep(String cep);
}
