import 'package:qr_flutter/qr_flutter.dart';
import 'account.dart';

String createQrData(Map<String, String> userAccounts){
  String result = "";
  for (String social in userAccounts.keys){
    String account = userAccounts[social]!;
    String url = accountToLink(account, social);
    result += "$url\n";
  }
  return result;
}


QrImageView createQrImage(Map<String, String> userAccounts){
  String qrData = createQrData(userAccounts);
  return QrImageView(
    data: qrData,
    version: QrVersions.auto,
    size: 200.0,
  );
}
