import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String message;

  ProgressDialog(this.message);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.yellow,
      child: Expanded(
        child: Container(
          margin: EdgeInsets.all(15.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                SizedBox(width: 6.0),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
                SizedBox(width: 26.0),
                Flexible(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
