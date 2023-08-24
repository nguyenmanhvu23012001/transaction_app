import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:zen8app/models/sources/history.dart';
import 'package:zen8app/utils/extensions/stream_ext.dart';
import 'package:zen8app/utils/helpers/base_vm.dart';
import 'package:zen8app/utils/helpers/disposable.dart';

import '../../../../api/sources/main_service.dart';
import '../../../../utils/helpers/di.dart';

class HistoryVMInput extends Disposable{
  final reload = PublishSubject();
  @override
  void dispose() {
    reload.close();
    super.dispose();
  }
}

class HistoryVMOutput extends Disposable{
    final response = BehaviorSubject<List<HistoryModel>>();
    @override
  void dispose() {
      response.close();
    super.dispose();
  }
}

class HistoryVM extends BaseVM<HistoryVMInput,HistoryVMOutput>{
  HistoryVM():super(HistoryVMInput(),HistoryVMOutput());
  @override
  CompositeSubscription? connect() {
    final rxBag = CompositeSubscription();
    final mainService = DI.resolve<MainService>();

    input.reload
        .switchMap((param) => mainService.getHistory()
        .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.response)
        .addTo(rxBag);

    return rxBag;
  }

}