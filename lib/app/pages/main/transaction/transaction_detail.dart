import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zen8app/models/sources/transaction.dart';

import '../../../../widgets/sources/custom_appbar.dart';
@RoutePage()
class TransactionDetailPage extends StatefulWidget {
  final TransactionData transaction;
  TransactionDetailPage({required this.transaction});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
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
                        'Buyer',
                        widget.transaction.buyer.username,
                      ),
                      SizedBox(height: 20.0),
                      _buildInfoRow(
                        Icons.storefront,
                        Colors.green,
                        'Seller',
                        widget.transaction.seller.username,
                      ),
                      SizedBox(height: 20.0),
                      _buildInfoRow(
                        Icons.shopping_bag,
                        Colors.orange,
                        'Goods',
                        widget.transaction.goods,
                      ),
                      SizedBox(height: 20.0),
                      _buildInfoRow(
                        Icons.monetization_on,
                        Colors.teal,
                        'Transaction Money',
                        widget.transaction.transactionMoney.toString(),
                      ),
                      SizedBox(height: 20.0),
                      _buildInfoRow(
                        Icons.account_balance_wallet,
                        Colors.deepOrange,
                        'Deposit',
                        widget.transaction.deposit.toString(),
                      ),
                      SizedBox(height: 20.0),
                      _buildInfoRow(
                        Icons.access_time,
                        Colors.purple,
                        'Created At',
                        widget.transaction.createdAt.toString(),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) => UpdateTransactionFormModal(
                          //     transaction: widget.transaction,
                          //     transactionProvider: transactionProvider,
                          //    ),
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
                                content: Text('Are you sure you want to delete this transaction?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close the dialog
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
                      ),
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
}
