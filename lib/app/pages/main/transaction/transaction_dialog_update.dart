import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/src/utils/composite_subscription.dart';
import 'package:zen8app/app/pages/main/transaction/transaction_dialog_update_vm.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/models/models.dart';
import 'package:zen8app/models/sources/transaction.dart';
import 'package:zen8app/widgets/sources/loading_widget.dart';

import '../../../../utils/helpers/mvvm_binding.dart'; // Import your User model here

class UpdateTransactionFormModal extends StatefulWidget {
  final TransactionData transaction;
  UpdateTransactionFormModal({required this.transaction});
  @override
  State<UpdateTransactionFormModal> createState() =>
      _UpdateTransactionFormModalState();
}

class _UpdateTransactionFormModalState
    extends State<UpdateTransactionFormModal> with MVVMBinding<TransactionDialogUpdateVM,UpdateTransactionFormModal>{
  User? _selectedBuyer;
  User? _selectedSeller;
  final TextEditingController goods = TextEditingController();
  final TextEditingController transactionMoney = TextEditingController();
  final TextEditingController deposit = TextEditingController();
  List<User> _users = []; // Make sure to populate this list with User objects
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // super.initState();
    _selectedBuyer = widget.transaction.buyer;
    _selectedSeller = widget.transaction.seller;
    goods.text = widget.transaction.goods;
    transactionMoney.text=widget.transaction.transactionMoney.toString();
    deposit.text = widget.transaction.deposit.toString();
    // Initialize _users list with User objects if necessary
  }
  void updatePostButton(String id){
      String goodsValue = goods.text;
      double depositValue = double.parse(deposit.text);
      double transactionMoneyValue = double.parse(transactionMoney.text);
      TransactionData transaction = TransactionData(
          id: id,
          buyer: widget.transaction.buyer,
          seller: widget.transaction.seller,
          goods: goodsValue,
          transactionMoney: transactionMoneyValue,
          deposit: depositValue,
          isDeleted: widget.transaction.isDeleted,
          createdAt: widget.transaction.createdAt,
          updatedAt: widget.transaction.updatedAt
      );

}

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      error: vm.errorTracker.asAppException(),
      isLoading: vm.activityTracker.isRunningAny(),
      child: AlertDialog(
        title: Text("Edit Transaction"),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDropdownFormField(
                  label: 'Select a buyer',
                  value: _selectedBuyer,
                  onChanged: (User? newValue) {
                    setState(() {
                      _selectedBuyer = newValue;
                    });
                  },
                  validator: (User? value) {
                    if (value == null) {
                      return 'Please select a buyer';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildDropdownFormField(
                  label: 'Select a seller',
                  value: _selectedSeller,
                  onChanged: (User? newValue) {
                    setState(() {
                      _selectedSeller = newValue;
                    });
                  },
                  validator: (User? value) {
                    if (value == null) {
                      return 'Please select a seller';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.0),
                _buildTextFormField(
                  controller: goods,
                  label: 'Goods',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter goods';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: transactionMoney,
                  label: 'Transaction Money',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter transaction money';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: deposit,
                  label: 'Deposit',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter deposit';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedBuyer == null || _selectedSeller == null) {
                // Show an error message or perform an action
                return;
              }
              if (_formKey.currentState!.validate()) {
                // Form is valid, you can proceed with updating the transaction
              }
            },
            child: ElevatedButton(
              onPressed: () {
                vm.input.update;
                updatePostButton(widget.transaction.id??"");
              },
              child: Text('Edit'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownFormField({
    required String label,
    required User? value,
    required void Function(User?) onChanged,
    required String? Function(User?) validator,
  }) {
    return   DropdownButtonFormField<User>(
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
    required String label,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: validator,
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


  }


  @override
  TransactionDialogUpdateVM onCreateVM() {
    return TransactionDialogUpdateVM();
  }

  void reload() {
    vm.input.reload.add(null);
  }


}
