import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/router/router.dart';
import 'package:zen8app/utils/helpers/event_bus.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[300], // Background color for the Drawer
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 45),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home', style: TextStyle(fontSize: 16)),
            onTap: () {
              print("--> ");
              context.router.replaceAll([const HomeRoute()]);
            },
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Transaction', style: TextStyle(fontSize: 16)),
            onTap: () {
                context.router.push( const TransactionRoute());
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History', style: TextStyle(fontSize: 16)),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Wallet', style: TextStyle(fontSize: 16)),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out', style: TextStyle(fontSize: 16)),
            onTap: () {
              EventBus.shared.post(event: AppEvent.forceLogout,data: "User logout");
            },
          ),
        ],
      ),
    );



  }
}
