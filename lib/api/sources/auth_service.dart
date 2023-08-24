import 'package:rxdart/rxdart.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/models/sources/login_response.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/models/models.dart';

class AuthService {
  Stream<LoginResponse> login(String username, String password) {
   return Session.publicClient.postStream('/slink/v1/auth/login',data: {
     "username" : username,
     "password" : password,
   }).decode((json) {
     print(json);
     return LoginResponse.fromJson(json['data']);});
  }

  // Stream<Transaction> getTrans(){
  //
  // }
}
