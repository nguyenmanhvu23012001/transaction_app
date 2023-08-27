import 'package:flutter/material.dart';
import 'package:rxdart/src/utils/composite_subscription.dart';
import 'package:zen8app/app/pages/main/transaction/transaction_dialog_vm.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/router/router.dart';
import 'package:zen8app/utils/helpers/mvvm_binding.dart';
import 'package:zen8app/widgets/sources/loading_widget.dart';
import '../../../../models/sources/transaction.dart';
import '../../../../models/sources/user.dart';
import '../../../../models/sources/user_infor.dart';

class AddTransactionFormModal extends StatefulWidget {
  const AddTransactionFormModal();

  @override
  _AddTransactionFormModalState createState() =>
      _AddTransactionFormModalState();
}

class _AddTransactionFormModalState extends State<AddTransactionFormModal>
    with MVVMBinding<TransactionDialogVM, AddTransactionFormModal> {
  User? _selectedBuyer;
  User? _selectedSeller;
  final TextEditingController goods = TextEditingController(text: "halo");
  final TextEditingController transactionMoney = TextEditingController(text: "123");
  final TextEditingController deposit = TextEditingController(text: "14");


  List<User> _users = [];
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      error: vm.errorTracker.asAppException(),
      isLoading: vm.activityTracker.isRunningAny(),
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text('Transaction'),
          content: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDropdown(
                    value: _selectedBuyer,
                    onChanged: (User? newValue) {
                      setState(() {
                        _selectedBuyer = newValue;
                      });
                    },

                    users: _users,
                    hintText: "Select a buyer",
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a buyer';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  _buildDropdown(
                    value: _selectedSeller,
                    onChanged: (User? newValue) {
                      setState(() {
                        _selectedSeller = newValue;
                      });
                    },
                    users: _users,
                    hintText: "Select a seller",
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a seller';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  _buildTextFormField(
                    controller: goods,
                    labelText: 'Goods',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter goods';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  _buildTextFormField(
                    controller: transactionMoney,
                    labelText: 'Transaction Money',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter transaction money';
                      }
                      double? parsedValue = double.tryParse(value);
                      if (parsedValue == null || parsedValue <= 0) {
                        return 'Please enter a valid transaction money';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  _buildTextFormField(
                    controller: deposit,
                    labelText: 'Deposit',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter deposit';
                      }
                      double? parsedValue = double.tryParse(value);
                      if (parsedValue == null || parsedValue < 0) {
                        return 'Please enter a valid deposit';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            _buildTextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  TransactionData transaction = TransactionData(
                      id: '',
                      buyer: _selectedBuyer!,
                      seller: _selectedSeller!,
                      goods: goods.text,
                      transactionMoney: double.parse(transactionMoney.text),
                      deposit: double.parse(deposit.text),
                      isDeleted: false,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now());
                  addTransaction(transaction);
                }

              },
              text: 'Add',
              textColor: Colors.green,
            ),
            _buildTextButton(
              onPressed: () => Navigator.of(context).pop(),
              text: 'Close',
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required List<User> users,
    required void Function(User?) onChanged,
    required String hintText,
    required User? value,
    required String? Function(dynamic value) validator,
  }) {
    return DropdownButtonFormField<User>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        filled: true,
      ),
      validator: validator,
      value: value,
      onChanged:onChanged,
      items: _users
          .map(
            (e) => DropdownMenuItem<User>(
              child: Container(
                child: Text(e.username),
              ),
              value: e,
            ),
          )
          .toList(),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(dynamic value) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildTextButton({
    required VoidCallback onPressed,
    required String text,
    required Color textColor,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: textColor)),
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
      context.router.pop();

    });
  }

  void addTransaction(TransactionData transactionData) {
    vm.input.add.add(transactionData);
  }

  @override
  TransactionDialogVM onCreateVM() {
    return TransactionDialogVM();
  }

  void reload() {
    vm.input.reload.add(null);
  }
}
