import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/src/utils/composite_subscription.dart';
import 'package:zen8app/app/pages/main/wallet/wallet_dialog_add_vm.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/models/models.dart';
import 'package:zen8app/router/router.dart';
import 'package:zen8app/widgets/sources/loading_widget.dart';

import '../../../../models/sources/wallet.dart';
import '../../../../utils/helpers/mvvm_binding.dart';

class AddWalletFormModal extends StatefulWidget {
  const AddWalletFormModal({Key? key}) : super(key: key);
  @override
  State<AddWalletFormModal> createState() => _AddWalletFormModalState();
}

class _AddWalletFormModalState extends State<AddWalletFormModal> with MVVMBinding<WalletDialogVM,AddWalletFormModal> {
  User? _selectedUser;
  final TextEditingController user = TextEditingController();
  final TextEditingController deposit = TextEditingController();
  final TextEditingController debit = TextEditingController();
  List _users = [];
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      isLoading: vm.activityTracker.isRunningAny(),
      error: vm.errorTracker.asAppException(),
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text('Wallet'),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<User>(
                    value: _selectedUser,
                    onChanged: (User? newValue) {
                      setState(() {
                        _selectedUser = newValue;
                      });
                    },
                    items: _users
                        .map((user) => DropdownMenuItem<User>(
                      value: user,
                      child: Text(user.username), // Display username
                    ))
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'User',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (_selectedUser == null) {
                        return 'Please select a user.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: deposit,
                    decoration: InputDecoration(
                      labelText: 'Deposit',
                      border: OutlineInputBorder(),
                    ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a deposit value.';
                        }
                        // You can add additional validation logic here.
                        return null;
                      }
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: debit,
                    decoration: InputDecoration(
                      labelText: 'Debit',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                        if (value == null || value.isEmpty) {
                        return 'Please enter a debit value.';
                        }
                        // You can add additional validation logic here.
                        return null; // Return null if the input is valid. Return null if the input is valid.
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  WalletModel wallet = WalletModel(
                      id: '',
                      user: _selectedUser!,
                      debit: double.parse(debit.text),
                      deposit: double.parse(deposit.text),
                      createdAt: DateTime.now().toString(),
                      updatedAt: DateTime.now().toString());
                  addWallet(wallet);
                  print(wallet);

                }
              },
              child: Text('Add', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onBindingVM(CompositeSubscription subscription) {
    vm.output.response.listen((value) {
      print(value.length);
      setState(() {
        _users = value;
      });
    }).addTo(subscription);
    reload();

    vm.output.addResponse.listen((value) {
      context.router.replaceAll([HomeRoute(),WalletRoute()],updateExistingRoutes: false);

    });
  }

  void addWallet(WalletModel walletModel) {
    vm.input.add.add(walletModel);
  }

  @override
  WalletDialogVM onCreateVM() {
    return WalletDialogVM();
  }

  void reload() {
    vm.input.reload.add(null);
  }
}
