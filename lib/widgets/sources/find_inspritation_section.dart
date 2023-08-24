import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindInspirationSection extends StatefulWidget {
  const FindInspirationSection({Key? key}) : super(key: key);

  @override
  State<FindInspirationSection> createState() => _FindInspirationSectionState();
}

class _FindInspirationSectionState extends State<FindInspirationSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Intermediary ',
                style: TextStyle(color: Colors.black87, fontSize: 25),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Transactions',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 243, 243, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      hintText: "Search you're looking for",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
