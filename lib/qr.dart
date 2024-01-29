import 'package:qr_flutter/qr_flutter.dart';
import 'account.dart';
import 'package:flutter/material.dart';


String createQrData(Map<String, dynamic> userAccounts){
  String result = "";
  for (String social in userAccounts.keys){
    if (userAccounts[social]!['visibility'] == 1){
      String account = userAccounts[social]!['account'];
      String url = accountToLink(account, social);
      result += "$url\n";
    }
  }
  return result;
}



class QrWidget extends StatefulWidget {
  final Map<String, dynamic> userAccounts;
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
    qrData = createQrData(widget.userAccounts);
    return QrImageView(
      data: qrData,
      version: QrVersions.auto,
      size: 200.0,
    );
  }

}