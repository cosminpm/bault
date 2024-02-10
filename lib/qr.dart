import 'package:qr_flutter/qr_flutter.dart';
import 'account.dart';
import 'package:flutter/material.dart';

String createQrData(Map<dynamic, dynamic> userAccounts) {
  String result = "";
  for (String social in userAccounts.keys) {
    if (userAccounts[social]!['visibility'] == 1) {
      String account = userAccounts[social]!['account'];
      String url = accountToLink(account, social);
      result += "$url\n";
    }
  }
  return result;
}

class QrWidget extends StatefulWidget {
  final Map<dynamic, dynamic> userAccounts;
  final Function updateQrData;

  const QrWidget({
    required this.userAccounts,
    required this.updateQrData,
    Key? key,
  }) : super(key: key);

  @override
  _QrWidgetState createState() => _QrWidgetState();
}

class _QrWidgetState extends State<QrWidget> {
  String qrData = "";

  void updateQrData() {
    setState(() {
      qrData = createQrData(widget.userAccounts);
    });
  }

  @override
  void initState() {
    super.initState();
    updateQrData();
  }

  @override
  Widget build(BuildContext context) {

    if (allVisibilityZero(widget.userAccounts)){
      return Container(
        child:       Container(
          child: Image(
            height: 200,
            width: 200,
            image: AssetImage(
              'logo_bault_no_borders.png',
            ),
          ),
      ));
    }

    qrData = createQrData(widget.userAccounts);


    return QrImageView(
      data: qrData,
      version: QrVersions.auto,
      size: 200.0,
    );
  }
}

bool allVisibilityZero(Map<dynamic, dynamic> accounts) {
  for (var value in accounts.values) {
    if (value['visibility'] != 0) {
      return false;
    }
  }
  return true;
}