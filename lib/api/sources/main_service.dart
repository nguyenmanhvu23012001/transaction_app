import 'package:rxdart/rxdart.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/models/sources/history.dart';
import 'package:zen8app/models/sources/transaction.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/models/models.dart';

class MainService {
  Stream<List<TransactionData>> getTransaction() {
    return Session.authClient
        .getStream('/slink/v1/transactions')
        .decodeListWithData((json) => TransactionData.fromJson(json));
  }

  Stream<List<HistoryModel>> getHistory() {
    return Session.authClient
        .getStream('/slink/v1/historys')
        .decodeListWithData((json) => HistoryModel.fromJson(json));
  }
}
