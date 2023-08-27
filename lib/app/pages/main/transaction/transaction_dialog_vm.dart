import 'package:rxdart/rxdart.dart';
import 'package:zen8app/models/sources/transaction.dart';
import 'package:zen8app/models/sources/user_infor.dart';
import 'package:zen8app/utils/extensions/stream_ext.dart';
import 'package:zen8app/utils/helpers/base_vm.dart';
import 'package:zen8app/utils/helpers/disposable.dart';

import '../../../../api/sources/main_service.dart';
import '../../../../models/sources/user.dart';
import '../../../../utils/helpers/di.dart';

class TransactionDialogVMInput extends Disposable{
  final reload = PublishSubject();
  final add = PublishSubject<TransactionData>();

  @override
  void dispose() {
    reload.close();
    add.close();
  }

}
class TransactionDialogVMOutput extends Disposable{
  final response = BehaviorSubject<List<User>>();
  final addResponse = BehaviorSubject<TransactionData>();

  @override
  void dispose() {
      addResponse.close();
    response.close();
  }
}
class TransactionDialogVM extends BaseVM<TransactionDialogVMInput,TransactionDialogVMOutput>{
  TransactionDialogVM() : super(TransactionDialogVMInput(),TransactionDialogVMOutput());

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
        .addTransaciton(value)
        .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.addResponse)
        .addTo(rxBag);
    return rxBag;
  }


}