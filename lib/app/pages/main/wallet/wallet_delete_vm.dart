import 'package:rxdart/rxdart.dart';
import 'package:zen8app/utils/extensions/stream_ext.dart';
import 'package:zen8app/utils/helpers/base_vm.dart';
import 'package:zen8app/utils/helpers/disposable.dart';

import '../../../../api/sources/main_service.dart';
import '../../../../utils/helpers/di.dart';

class WalletDeleteVMInput extends Disposable{
  final delete = PublishSubject<String>();
  @override
  void dispose() {
    delete.close();
    super.dispose();
  }
}
class  WalletDeleteVMOutput extends Disposable{
  final response = BehaviorSubject();
  @override
  void dispose() {
    response.close();
    super.dispose();
  }
}
class WalletDeleteVM extends BaseVM<WalletDeleteVMInput,WalletDeleteVMOutput>{
  WalletDeleteVM() : super(WalletDeleteVMInput(),WalletDeleteVMOutput());
  @override
  CompositeSubscription? connect() {
    final rxBag = CompositeSubscription();
    final mainService = DI.resolve<MainService>();

    input.delete
        .switchMap((value) => mainService
        .deleteWallet(value)
        .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.response)
        .addTo(rxBag);
    return rxBag;
  }
}