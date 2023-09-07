import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zen8app/app/pages/main/wallet/wallet_delete_vm.dart';
import 'package:zen8app/models/sources/wallet.dart';
import 'package:zen8app/utils/helpers/mvvm_binding.dart';
import 'package:zen8app/widgets/sources/custom_appbar.dart';

import '../../../../router/router.dart';

@RoutePage()
class WalletDetailPage extends StatefulWidget {
  final WalletModel wallet;
  WalletDetailPage({required this.wallet});
  @override
  _WalletDetailPageState createState() => _WalletDetailPageState();
}

class _WalletDetailPageState extends State<WalletDetailPage>
    with MVVMBinding<WalletDeleteVM, WalletDetailPage> {
  late BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
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
                        widget.wallet.user.username,
                      ),
                      SizedBox(height: 20.0),
                      _buildInfoRow(
                        Icons.monetization_on,
                        Colors.orange,
                        'Deposit',
                        widget.wallet.deposit.toString(),
                      ),
                      SizedBox(height: 20.0),
                      _buildInfoRow(
                        Icons.monetization_on,
                        Colors.teal,
                        'Debit',
                        widget.wallet.debit.toString(),
                      ),
                      SizedBox(height: 20.0),
                      _buildInfoRow(
                        Icons.account_balance_wallet,
                        Colors.deepOrange,
                        'Created At',
                        widget.wallet.createdAt.toString(),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) => UpdateTransactionFormModal(
                          //     transaction: widget.wallet,),
                          // );
                        },
                        child: _buildInfoRow(
                          Icons.edit,
                          Colors.purple,
                          'Edit',
                          'Edit Transaction',
                        ),
                      ),
                      SizedBox(height: 20.0),
                     GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Delete'),
                              content: Text('Are you sure you want to delete this wallet?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    vm.input.delete.add(widget.wallet.id);
                                  },
                                  child: Text('Delete'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                        child: _buildInfoRow(
                          Icons.delete,
                          Colors.deepOrange,
                          'Delete',
                          'Delete Transaction',
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon, Color color, String title, String content) {
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
      context.router.replaceAll([HomeRoute(), WalletRoute()],
          updateExistingRoutes: false);
    }).addTo(subscription);
  }

  @override
  WalletDeleteVM onCreateVM() {
    return WalletDeleteVM();
  }
}
