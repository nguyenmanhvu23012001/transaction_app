import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/src/utils/composite_subscription.dart';
import 'package:zen8app/app/pages/main/transaction/transaction_vm.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/utils/helpers/mvvm_binding.dart';
import 'package:zen8app/widgets/widgets.dart';
import '../../../../models/sources/transaction.dart';
import '../../../../widgets/sources/drawer_bar.dart';
import '../../../../widgets/sources/find_inspritation_section.dart';
@RoutePage()
class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> with MVVMBinding<TransactionVM,TransactionPage>{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late BuildContext scaffoldContext;
  List<TransactionData> _transactions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scaffoldContext = context;
    return LoadingWidget(
      isLoading: vm.activityTracker.isRunningAny(),
      error: vm.errorTracker.asAppException(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(244, 243, 243, 1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black87,
            ),
            onPressed: () {
              print("Menu Icon Được Nhấn");
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // _showTransactionDialog(scaffoldContext);
          },
          tooltip: 'Add Transaction',
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
          backgroundColor: Colors.grey,
          elevation: 6,
          splashColor: Colors.tealAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // Điều chỉnh độ tròn
          ),
        ),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FindInspirationSection(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Transactions',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _transactions.length,
                        itemBuilder: (BuildContext context, int index) {
                          var transaction = _transactions[index];
                          return GestureDetector(
                            onTap: () {
                              // Handle transaction tap
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow(Icons.person_outline, Colors.blue, 'Buyer',transaction.buyer.username /* transaction.buyer.name */),
                                    const SizedBox(height: 15),
                                    _buildInfoRow(Icons.storefront, Colors.green, 'Seller',  transaction.seller.username),
                                    const SizedBox(height: 15),
                                    _buildInfoRow(Icons.shopping_bag, Colors.orange, 'Goods', transaction.goods),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, Color color, String title, String content) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 30,
        ),
        SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              content,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }

  @override
  void onBindingVM(CompositeSubscription subscription) {
    vm.output.response.listen((value) {
      setState(() {
        _transactions = value ;
      });
    }).addTo(subscription);

    reload();
  }

  @override
  TransactionVM onCreateVM() {
    return TransactionVM();
  }

  void reload(){
    vm.input.reload.add(null);
  }
}
