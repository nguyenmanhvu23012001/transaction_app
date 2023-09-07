import 'package:zen8app/core/core.dart';
import 'package:zen8app/models/sources/history.dart';
import 'package:zen8app/models/sources/transaction.dart';
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
  
  Stream updateTransaction(TransactionData updateTransaction,String id){
    return Session.authClient.putStream('/slink/v1/transactions/$id',data: {
      "buyer":updateTransaction.buyer.id,
      "seller": updateTransaction.seller.id,
      "goods": updateTransaction.goods,
      "transaction_money" : updateTransaction.transactionMoney,
      "deposit" : updateTransaction.deposit
    });
  }

  Stream deleteTransaction(String id){
    return Session.authClient.deleteStream('/slink/v1/transactions/$id');
  }
  
  Stream<List<HistoryModel>> getHistory() {
    return Session.authClient
        .getStream('/slink/v1/historys')
        .decodeListWithData((json) => HistoryModel.fromJson(json));
  }
  //Wallet Services
  Stream<List<WalletModel>> getWallet(){
    return Session.authClient
        .getStream('/slink/v1/wallets')
        .decodeListWithData((json) => WalletModel.fromJson(json));
  }
  Stream addWallet(WalletModel wallet ){
    return Session.authClient.postStream('/slink/v1/wallets',data:{
      "user": wallet.user.id,
      "deposit": wallet.deposit,
      "debit": wallet.debit,
    }).decode((json) {
      wallet.id = json["data"]['_id'];
      return wallet;
    });
  }
  Stream  deleteWallet(String id){
    return Session.authClient.deleteStream('/slink/v1/wallets/$id');
  }

  //Login Services
  Stream<List<User>> getUser(){
    return Session.authClient
        .getStream('/slink/v1/users')
        .decodeListWithData((json) => User.fromJson(json));
  }
}
