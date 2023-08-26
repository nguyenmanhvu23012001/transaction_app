

import 'package:flutter/material.dart';
import 'package:rxdart/src/utils/composite_subscription.dart';
import 'package:zen8app/app/pages/main/transaction/transaction_dialog_vm.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/utils/helpers/mvvm_binding.dart';
import 'package:zen8app/widgets/sources/loading_widget.dart';
import '../../../../models/sources/user.dart';
import '../../../../models/sources/user_infor.dart';

class AddTransactionFormModal extends StatefulWidget{
  const AddTransactionFormModal();

  @override
  _AddTransactionFormModalState createState() =>
      _AddTransactionFormModalState();
}

class _AddTransactionFormModalState extends State<AddTransactionFormModal>  with MVVMBinding<TransactionDialogVM,AddTransactionFormModal>{
  User? _selectedBuyer;
  User? _selectedSeller;
  final TextEditingController goods = TextEditingController();
  final TextEditingController transactionMoney = TextEditingController();
  final TextEditingController deposit = TextEditingController();
  List<User> _users = [];

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      error: vm.errorTracker.asAppException(),
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text('Transaction'),
          content: Padding(
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
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: goods,
                  labelText: 'Goods',
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: transactionMoney,
                  labelText: 'Transaction Money',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: deposit,
                  labelText: 'Deposit',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            _buildTextButton(
              onPressed: () {
                // Add transaction logic here
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
  }) {
    return
    DropdownButtonFormField<User?>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder( //<-- SEE HERE
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: OutlineInputBorder( //<-- SEE HERE
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        filled: true,
      ),
      value: _selectedBuyer,
      onChanged: (User? user) {
        setState(() {
          _selectedBuyer = user;
        });
      },
      items: _users.map((e) => DropdownMenuItem<User>(child: Container(
        child: Text(e.username),
      ),value: e,),).toList(),
    );

  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
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
         _users=value;
        });
      }).addTo(subscription);
      reload();
  }

  @override
  TransactionDialogVM onCreateVM() {
    return TransactionDialogVM();
  }
  void reload(){
    vm.input.reload.add(null);
  }
}
