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
  @override
  void dispose() {
    reload.close();
    super.dispose();
  }

}
class TransactionDialogVMOutput extends Disposable{
  final response = BehaviorSubject<List<User>>();
  @override
  void dispose() {
    response.close();
    super.dispose();
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

    return rxBag;
  }


}