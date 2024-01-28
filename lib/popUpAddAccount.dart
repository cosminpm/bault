import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'accountConfig.dart';


class CustomPopup extends StatefulWidget {
  @override
  _CustomPopupState createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.xmark),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ...addMultipleAccounts(accountsConfigurations),
            ],
          )
        ],
      ),
    );
  }
}


List<Widget> addMultipleAccounts(Map<String, dynamic> accountConfigs){
  List<Widget> result = [];
  for (String account in accountConfigs.keys){
    result.add(addOneAccount(account, accountConfigs[account]));
    result.add(SizedBox(height: 10));
  }
  return result;
}


Widget addOneAccount(String id, Map<String, dynamic> accountConfig) {
  return Column(
    children: [
      Row(
        children: [
          Icon(accountConfig[ICON], size: 30,),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                border: Border.all(
                  color: Colors.grey, // Border color
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '...',
                    border: InputBorder.none, // Hide the default border of TextField
                  ),
                  onChanged: (value) {
                    // Handle text field value changes here
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
