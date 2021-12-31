import 'package:flutter/material.dart';

class TxDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TXNAME",
                      style: TextStyle(
                         fontSize: 22,
                         fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "TXPRICE",
                      style: TextStyle(
                         fontSize: 22,
                         fontWeight: FontWeight.bold,
                         color: Colors.green
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "DATE_CREATED",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "TIME_CREATED",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
