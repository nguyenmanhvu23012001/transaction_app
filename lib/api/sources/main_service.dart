import 'package:rxdart/rxdart.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/models/sources/history.dart';
import 'package:zen8app/models/sources/transaction.dart';
import 'package:zen8app/models/sources/user_infor.dart';
import 'package:zen8app/models/sources/wallet.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/models/models.dart';

class MainService {
  
  // Transaction Services
  Stream<List<TransactionData>> getTransaction() {
    return Session.authClient
        .getStream('/slink/v1/transactions')
        .decodeListWithData((json) => TransactionData.fromJson(json));
  }
  
  Stream addTransaciton(TransactionData transaction ){
    return Session.authClient.postStream('/slink/v1/transactions',data:{
      "buyer": transaction.buyer.id,
      "seller": transaction.seller.id,
      "goods": transaction.goods,
      "transaction_money" : transaction.transactionMoney,
      "deposit" : transaction.deposit
    }).decode((json) {
      transaction.id = json["data"]['_id'];
      return transaction;
    });
  }

  Stream<List<HistoryModel>> getHistory() {
    return Session.authClient
        .getStream('/slink/v1/historys')
        .decodeListWithData((json) => HistoryModel.fromJson(json));
  }
  
  Stream<List<WalletModel>> getWallet(){
    return Session.authClient
        .getStream('/slink/v1/wallets')
        .decodeListWithData((json) => WalletModel.fromJson(json));
  }

  Stream<List<User>> getUser(){
    return Session.authClient
        .getStream('/slink/v1/users')
        .decodeListWithData((json) => User.fromJson(json));
  }
}
