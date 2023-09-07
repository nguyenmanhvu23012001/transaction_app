import 'package:rxdart/rxdart.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/models/sources/login_response.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/models/models.dart';

import '../../models/sources/user_infor.dart';

class AuthService {
  Stream<LoginResponse> login(String username, String password) {
   return Session.publicClient.postStream('/slink/v1/auth/login',data: {
     "username" : username,
     "password" : password,
   }).decode((json) {
     print(json);
     return LoginResponse.fromJson(json['data']);});
  }

  Stream<User> register(String username,String password,String email,String numberPhone){
    return Session.publicClient.postStream('/slink/v1/auth/register',data: {
      "username" : username,
      "password" : password,
      "email" : email,
      "number_phone" : numberPhone

    }).decode((json) => User.fromJson(json['data']));
  }
}
