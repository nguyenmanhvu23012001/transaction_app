import 'package:rxdart/rxdart.dart';
import 'package:zen8app/models/models.dart';
import 'package:zen8app/models/sources/transaction.dart';
import 'package:zen8app/utils/extensions/stream_ext.dart';
import 'package:zen8app/utils/helpers/base_vm.dart';
import 'package:zen8app/utils/helpers/disposable.dart';

import '../../../../api/sources/main_service.dart';
import '../../../../utils/helpers/di.dart';

class TransactionDialogUpdateVMInput extends Disposable{
  final reload = PublishSubject();
  final update = PublishSubject<TransactionData>();
  @override
  void dispose() {
    reload.close();
    update.close();
    super.dispose();
  }
}

class TransactionDialogUpdateVMOutput extends Disposable{
  final response = BehaviorSubject<List<User>>();
  final updateReponse = BehaviorSubject<TransactionData>();
  @override
  void dispose() {
    response.close();
    updateReponse.close();
    super.dispose();
  }
}
class TransactionDialogUpdateVM extends BaseVM<TransactionDialogUpdateVMInput,TransactionDialogUpdateVMOutput>{
  TransactionDialogUpdateVM() : super(TransactionDialogUpdateVMInput(),TransactionDialogUpdateVMOutput());
  @override
  CompositeSubscription? connect() {
    final rxBag = CompositeSubscription();
    final mainService = DI.resolve<MainService>();


    input.reload
    .switchMap((value) => mainService.getUser())
    .trackActivity("loading", activityTracker)
    .handleErrorBy(errorTracker)
    .bindTo(output.response)
    .addTo(rxBag);

    input.update
        .switchMap((value) => mainService
        .addTransaciton(value)
        .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.updateReponse)
        .addTo(rxBag);
    return rxBag;
  }



}
