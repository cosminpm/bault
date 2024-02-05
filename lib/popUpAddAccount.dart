import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'account.dart';
import 'accountConfig.dart';
import 'main.dart';


class CustomPopup extends StatefulWidget {
  final AccountManager accountManager;

  const CustomPopup({
    required this.accountManager,
    Key? key,
  }) : super(key: key);

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
  Widget addOneAccount(String id, Map<String, dynamic> accountConfig) {
    String hintText = "";
    if (userAccount[id] != null) {
      hintText = userAccount[id]?['account'];
    }


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
                    controller: TextEditingController(text: hintText),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      int visibility = value != "" ? 1: 0;
                      userAccount[id] = {'account': value, 'visibility':visibility};
                      widget.accountManager.onUpdate();
                      print(userAccount[id]);

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

  List<Widget> addMultipleAccounts(Map<String, dynamic> accountConfigs){
    List<Widget> result = [];
    for (String account in accountConfigs.keys){
      result.add(addOneAccount(account, accountConfigs[account]));
      result.add(SizedBox(height: 10));
    }
    return result;
  }
}





