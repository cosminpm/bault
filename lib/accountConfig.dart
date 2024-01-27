import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const String URL = "url";
const String ICON = "icon";
const String ACCOUNT_VAR = "<ACCOUNT_VAR>";
const String ID = "id";

Map<String, String> idToAccount = {
  "1": "instagram",
  "2": "twitter",
  "3": "snapchat",
  "4": "linkedin",
};

Map<String, Map<String, dynamic>> accounts = {
  "instagram": {
    ID: "1",
    URL: "https://www.instagram.com/$ACCOUNT_VAR",
    ICON: FontAwesomeIcons.instagram
  },
  "twitter": {
    ID: "2",
    URL: "https://twitter.com/$ACCOUNT_VAR",
    ICON: FontAwesomeIcons.twitter
  }
  ,
  "snapchat":{
    ID: "3",
    URL: "https://www.snapchat.com/add/$ACCOUNT_VAR",
    ICON: FontAwesomeIcons.snapchat
  },
  "linkedin":{
    ID: "4",
    URL: "https://www.linkedin.com/in/$ACCOUNT_VAR",
    ICON: FontAwesomeIcons.linkedin
  }
};
