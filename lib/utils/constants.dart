import 'package:flutter/cupertino.dart';
import 'colors.dart';

/// This file has the Constants and TextStyles used in the application

//const currencySymbol = '\$';
const currencySymbol = '€';

TextStyle dishNameTextStyle1 = TextStyle(
  fontSize: 16,
  color: textColor,
  fontWeight: FontWeight.bold,
);
TextStyle priceTextStyle = TextStyle(
  fontSize: 14.0,
  color: greyColor,
);
TextStyle loginHeaderTextStyle = TextStyle(
  fontSize: 22.0,
  color: black,
  fontWeight: FontWeight.bold,
);

TextStyle dishCatergoryNameTextStyle = TextStyle(
  color: black,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

TextStyle dishCatergoryNameDetailsTextStyle = TextStyle(
  color: black,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);

TextStyle signUpTextStyle = TextStyle(
    color: greenColor,
    fontFamily: 'Trueno',
    decoration: TextDecoration.underline);

TextStyle signInButtonStyle = TextStyle(fontSize: 18.0, color: whiteColor);

TextStyle bestSellerTextStyle = const TextStyle(
  fontSize: 16.0,
);

TextStyle placeHolderStyle = TextStyle(color: black);

TextStyle totalAmountStyle = TextStyle(
  color: primaryColor,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);

TextStyle totalAmountLabelStyle = TextStyle(
  color: primaryColor,
  fontSize: 14.0,
);

TextStyle cartEmptyMessageStyle = TextStyle(
  color: greyColor,
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);

TextStyle addAddressTextStyle = TextStyle(
  color: black,
  fontSize: 16.0,
);

TextStyle addAddressTypeStyle = TextStyle(
  color: black,
  fontSize: 16.0,
);
TextStyle addressTypeOptionsStyle = TextStyle(
  color: black,
  fontSize: 14.0,
);

TextStyle orderSuccessMessageStyle = TextStyle(
  color: black,
  fontSize: 20.0,
);

TextStyle orderSuccessSubMessageStyle = TextStyle(
  color: black,
  fontSize: 15.0,
);
TextStyle addAddressLabelStyle = TextStyle(
  color: primaryColor,
  fontSize: 20.0,
);

BoxDecoration fieldDecoration = BoxDecoration(
  color: CupertinoColors.quaternarySystemFill,
  border: Border.all(
    color: CupertinoColors.systemGrey,
    width: 1,
  ),
  borderRadius: BorderRadius.circular(10),
);

TextStyle emptyAddressDataMessageStyle =
    TextStyle(color: greyColor, fontSize: 15.0);
