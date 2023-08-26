import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/src/utils/composite_subscription.dart';
import 'package:zen8app/app/pages/auth/wallet/wallet_vm.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/utils/helpers/mvvm_binding.dart';
import 'package:zen8app/widgets/sources/loading_widget.dart';

import '../../../../models/sources/wallet.dart';
import '../../../../widgets/sources/drawer_bar.dart';
import '../../../../widgets/sources/find_inspritation_section.dart';
@RoutePage()
class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with MVVMBinding<WalletVM,WalletPage>{
  late BuildContext scaffoldContext;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<WalletModel> _wallets = [];

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
            // _showWalletDialog(scaffoldContext);
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
                        'Wallet Transaction',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _wallets.length,
                        itemBuilder: (BuildContext context, int index) {
                          var _wallet = _wallets[index];
                          return GestureDetector(
                            onTap: () {},
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
                                    _buildInfoRow(
                                      Icons.person_outline,
                                      Colors.blue,
                                      'User',
                                      _wallet.user,
                                    ),
                                    const SizedBox(height: 15),
                                    _buildInfoRow(
                                      Icons.storefront,
                                      Colors.green,
                                      'Deposit',
                                      _wallet.deposit.toString(),
                                    ),
                                    const SizedBox(height: 15),
                                    _buildInfoRow(
                                      Icons.shopping_bag,
                                      Colors.orange,
                                      'Debit',
                                      _wallet.debit.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ], // Add this closing bracket
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
          _wallets =value;
        });
      }).addTo(subscription);
      return reload();
  }

  @override
  WalletVM onCreateVM() {
    return WalletVM();
  }
  void reload(){
    vm.input.reload.add(null);
  }

  // Uncomment this method
  // void _showWalletDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AddWalletFormModal();
  //     },
  //   );
  // }
}
