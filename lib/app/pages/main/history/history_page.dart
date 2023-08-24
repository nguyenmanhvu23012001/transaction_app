import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zen8app/app/pages/main/history/history_vm.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/utils/helpers/mvvm_binding.dart';
import 'package:zen8app/widgets/sources/loading_widget.dart';

import '../../../../models/sources/history.dart';
import '../../../../router/router.dart';
import '../../../../widgets/sources/drawer_bar.dart';
import '../../../../widgets/sources/find_inspritation_section.dart';
@RoutePage()
class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with MVVMBinding<HistoryVM,HistoryPage>{
  late BuildContext scaffoldContext;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<HistoryModel> _historys = []; // You need to populate this list with data

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
                        itemCount: _historys.length,
                        itemBuilder: (BuildContext context, int index) {
                          var _history = _historys[index];
                          return GestureDetector(
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
                                      'Transaction',
                                      _history.transactionId,
                                    ),
                                    const SizedBox(height: 15),
                                    _buildInfoRow(
                                      Icons.storefront,
                                      Colors.green,
                                      'Status',
                                      _history.status,
                                    ),
                                    const SizedBox(height: 15),
                                    _buildInfoRow(
                                      Icons.shopping_bag,
                                      Colors.orange,
                                      'Creat At',
                                      _history.createdAt.toString() ,
                                    ),
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
       _historys = value;
     });
   }).addTo(subscription);
   reload();
  }

  @override
  HistoryVM onCreateVM() {
   return HistoryVM();
  }
  void reload(){
    vm.input.reload.add(null);
  }


}
