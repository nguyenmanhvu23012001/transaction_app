import 'package:rxdart/rxdart.dart';
import 'package:zen8app/app/pages/main/transaction/transaction_dialog_update_vm.dart';
import 'package:zen8app/models/models.dart';
import 'package:zen8app/models/sources/transaction.dart';
import 'package:zen8app/utils/extensions/stream_ext.dart';
import 'package:zen8app/utils/helpers/base_vm.dart';
import 'package:zen8app/utils/helpers/disposable.dart';

import '../../../../api/sources/main_service.dart';
import '../../../../utils/helpers/di.dart';

class TransactionDeleteVMInput extends Disposable{
  final delete = PublishSubject<String>();
  @override
  void dispose() {
    delete.close();
    super.dispose();
  }
}

class TransactionDeleteVMOutput extends Disposable{
  final response = BehaviorSubject();
  @override
  void dispose() {
    response.close();
    super.dispose();
  }
}
class TransactionDeleteVM extends BaseVM<TransactionDeleteVMInput,TransactionDeleteVMOutput>{
  TransactionDeleteVM() : super(TransactionDeleteVMInput(),TransactionDeleteVMOutput());
  @override
  CompositeSubscription? connect() {
    final rxBag = CompositeSubscription();
    final mainService = DI.resolve<MainService>();

    input.delete
        .switchMap((value) => mainService
        .deleteTransaction(value)
        .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.response)
        .addTo(rxBag);
    return rxBag;
  }



}
