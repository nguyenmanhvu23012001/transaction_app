import 'package:rxdart/rxdart.dart';
import 'package:zen8app/models/sources/transaction.dart';
import 'package:zen8app/utils/extensions/stream_ext.dart';
import 'package:zen8app/utils/helpers/base_vm.dart';
import 'package:zen8app/utils/helpers/disposable.dart';

import '../../../../api/sources/main_service.dart';
import '../../../../utils/helpers/di.dart';

class TransactionVMInput extends Disposable {
  final reload = PublishSubject();
  @override
  void dispose() {
    reload.close();
    super.dispose();
  }
}

class TransactionVMOutput extends Disposable {
  final response = BehaviorSubject<List<TransactionData>>();


  @override
  void dispose() {
    response.close();
  }
}

class TransactionVM extends BaseVM<TransactionVMInput, TransactionVMOutput> {
  TransactionVM() : super(TransactionVMInput(), TransactionVMOutput());

  @override
  CompositeSubscription? connect() {
    final rxBag = CompositeSubscription();
    final mainService = DI.resolve<MainService>();

    input.reload
        .switchMap((param) => mainService
            .getTransaction()
            .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.response)
        .addTo(rxBag);



    return rxBag;
  }
}
