import 'package:rxdart/rxdart.dart';
import 'package:zen8app/models/sources/transaction.dart';
import 'package:zen8app/models/sources/user_infor.dart';
import 'package:zen8app/models/sources/wallet.dart';
import 'package:zen8app/utils/extensions/stream_ext.dart';
import 'package:zen8app/utils/helpers/base_vm.dart';
import 'package:zen8app/utils/helpers/disposable.dart';

import '../../../../api/sources/main_service.dart';
import '../../../../models/sources/user.dart';
import '../../../../utils/helpers/di.dart';

class WalletDialogVMInput extends Disposable{
  final reload = PublishSubject();
  final add = PublishSubject<WalletModel>();

  @override
  void dispose() {
    reload.close();
    add.close();
  }

}
class WalletDialogVMOutput extends Disposable{
  final response = BehaviorSubject<List<User>>();
  final addResponse = BehaviorSubject<WalletModel>();

  @override
  void dispose() {
    addResponse.close();
    response.close();
  }
}
class WalletDialogVM extends BaseVM<WalletDialogVMInput,WalletDialogVMOutput>{
  WalletDialogVM() : super(WalletDialogVMInput(),WalletDialogVMOutput());

  @override
  CompositeSubscription? connect() {
    final rxBag = CompositeSubscription();
    final mainService = DI.resolve<MainService>();

    input.reload
        .switchMap((param) => mainService.getUser()
        .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.response)
        .addTo(rxBag);

    input.add
        .switchMap((value) => mainService
        .addWallet(value)
        .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.addResponse)
        .addTo(rxBag);
    return rxBag;
  }
}