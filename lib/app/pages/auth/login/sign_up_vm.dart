import 'package:rxdart/rxdart.dart';
import 'package:zen8app/models/sources/user_infor.dart';
import 'package:zen8app/utils/extensions/stream_ext.dart';
import 'package:zen8app/utils/helpers/base_vm.dart';
import 'package:zen8app/utils/helpers/disposable.dart';

import '../../../../api/sources/auth_service.dart';
import '../../../../models/sources/user.dart';
import '../../../../utils/helpers/di.dart';

class SignUpInputVM extends Disposable{
  final signUp = PublishSubject<(String,String,String,String)>();
  @override
  void dispose() {
    signUp.close();
    super.dispose();
  }
}
class SignUpOutputVM extends Disposable{
  final response = PublishSubject<User>();
  @override
  void dispose() {
    response.close();
    super.dispose();
  }
}

class SignUpVM extends BaseVM<SignUpInputVM,SignUpOutputVM>{
  SignUpVM() : super(SignUpInputVM(),SignUpOutputVM());
  @override
  CompositeSubscription? connect() {
    final rxBag = CompositeSubscription();
    final authService = DI.resolve<AuthService>();

    input.signUp
        .switchMap((param) => authService
        .register(param.$1, param.$2,param.$3,param.$4)
        .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.response)
        .addTo(rxBag);

    return rxBag;
  }
}