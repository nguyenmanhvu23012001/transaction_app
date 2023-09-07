import 'package:rxdart/rxdart.dart';
import 'package:zen8app/models/sources/wallet.dart';
import 'package:zen8app/utils/extensions/stream_ext.dart';
import 'package:zen8app/utils/helpers/base_vm.dart';
import 'package:zen8app/utils/helpers/disposable.dart';

import '../../../../api/sources/main_service.dart';
import '../../../../utils/helpers/di.dart';

class WalletVMInput extends Disposable{
  final reload = PublishSubject();
  @override
  void dispose() {
    reload.close();
    super.dispose();
  }
}
class WalletVMOutput extends Disposable{
  final response = BehaviorSubject<List<WalletModel>>();
  @override
  void dispose() {
    response.close();
  }
}

class WalletVM extends BaseVM<WalletVMInput,WalletVMOutput>{
  WalletVM() : super(WalletVMInput(),WalletVMOutput());

  @override
  CompositeSubscription? connect() {
    final rxBag = CompositeSubscription();
    final mainService = DI.resolve<MainService>();

    input.reload
        .switchMap((param) => mainService.getWallet()
        .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.response)
        .addTo(rxBag);

    return rxBag;
  }
}