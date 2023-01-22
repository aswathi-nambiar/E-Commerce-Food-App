import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/common_textfield.dart';
import '../../common_widgets/loading.dart';
import '../../models/delivery_address_model.dart';
import '../../providers/review_cart_provider.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/validations.dart';

class NewDeliveryAddressPage extends StatefulWidget {
  const NewDeliveryAddressPage({Key? key}) : super(key: key);

  @override
  State<NewDeliveryAddressPage> createState() => _NewDeliveryAddressPageState();
}

class _NewDeliveryAddressPageState extends State<NewDeliveryAddressPage> {
  final _formKey = GlobalKey<FormState>();

  ///[TextEditingController] of Name, MobileNumber and delivery address fields
  TextEditingController firstNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController societyController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  /// field having address type. By default the
  /// address type home. So it is set true.
  bool isHomeSelected = true;
  bool loading = false;

  String error = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemYellow,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Icon(
              CupertinoIcons.back,
              color: CupertinoColors.black,
            ),
          ),
          middle: const Text('Add Delivery Address'),
        ),
        child:
            Consumer<ReviewCartProvider>(builder: (_, reviewCartProvider, __) {
          return loading
              ? const Loading()
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10.0),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.location_solid,
                                  color: greyColor,
                                ),
                                Text(
                                  'Deliver To',
                                  style: addAddressTextStyle,
                                )
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(height: 20.0),

                              /// first name field
                              CommonTextField(
                                textController: firstNameController,
                                textInputAction: TextInputAction.next,
                                hintText: 'NAME',
                                boxDecoration: fieldDecoration,
                                validator: (dynamic value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a first name';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 15.0),

                              /// Mobile number
                              CommonTextField(
                                textController: mobileNoController,
                                hintText: 'MOBILE NUMBER',
                                boxDecoration: fieldDecoration,
                                keyBoardType: TextInputType.number,
                                validator: (dynamic value) {
                                  bool isNameValid =
                                      Validations.isValidMobileNumber(
                                          mobileNoController.value.text);

                                  if (!isNameValid) {
                                    return 'Please enter valid Mobile Number';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 15.0),

                              /// house number
                              CommonTextField(
                                textController: societyController,
                                hintText: 'HOUSE/FLAT/BLOCK NO.',
                                boxDecoration: fieldDecoration,
                                validator: (dynamic value) {
                                  if (value.isEmpty) {
                                    return 'Please enter house number';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 15.0),

                              /// street
                              CommonTextField(
                                textController: streetController,
                                hintText: 'STREET NAME',
                                boxDecoration: fieldDecoration,
                                validator: (dynamic value) {
                                  if (value.isEmpty) {
                                    return 'Please your street name';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 15.0),

                              /// Area field
                              CommonTextField(
                                textController: areaController,
                                hintText: 'AREA (optional)',
                                boxDecoration: fieldDecoration,
                              ),
                              const SizedBox(height: 15.0),

                              /// Landmark field
                              CommonTextField(
                                textController: landmarkController,
                                hintText: 'LANDMARK (optional)',
                                boxDecoration: fieldDecoration,
                              ),
                              const SizedBox(height: 15.0),

                              ///city
                              CommonTextField(
                                textController: cityController,
                                hintText: 'CITY',
                                boxDecoration: fieldDecoration,
                                validator: (dynamic value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a city name';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 15.0),

                              /// Pincode field
                              CommonTextField(
                                textController: pinCodeController,
                                hintText: 'PINCODE',
                                boxDecoration: fieldDecoration,
                                keyBoardType: TextInputType.number,
                                validator: (dynamic value) {
                                  bool isNameValid = Validations.isValidPinCode(
                                      pinCodeController.value.text);

                                  if (!isNameValid) {
                                    return 'Please enter valid pincode';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 30.0),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Address Type:',
                                      style: addAddressTypeStyle,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: isHomeSelected
                                              ? primaryColor
                                              : transparentColor,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              CupertinoIcons.home,
                                              size: 23.0,
                                              color: greyColor,
                                            ),
                                            Text(
                                              'Home',
                                              style: addressTypeOptionsStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isHomeSelected = true;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: !isHomeSelected
                                              ? primaryColor
                                              : transparentColor,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              CupertinoIcons.briefcase,
                                              size: 23.0,
                                              color: greyColor,
                                            ),
                                            Text(
                                              'Work',
                                              style: addressTypeOptionsStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isHomeSelected = false;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /// Widget showing Place Order  button
                                    Expanded(
                                      flex: 2,
                                      child: CupertinoButton(
                                        color: primaryColor,
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() => loading = true);

                                            /// Add
                                            await reviewCartProvider
                                                .addDeliveryAddressData(
                                              address: DeliveryAddressModel(
                                                  firstName:
                                                      firstNameController.text,
                                                  mobileNo:
                                                      mobileNoController.text,
                                                  houseNumber:
                                                      societyController.text,
                                                  street: streetController.text,
                                                  area: areaController.text,
                                                  landMark:
                                                      landmarkController.text,
                                                  city: cityController.text,
                                                  pinCode:
                                                      pinCodeController.text,
                                                  isHomeAddress:
                                                      isHomeSelected),
                                            );
                                            if (reviewCartProvider.isLoading ==
                                                false) {
                                              if (!mounted) return;
                                              Navigator.of(
                                                context,
                                              ).pop();
                                            }
                                          }
                                        },
                                        child: const Text('Add Address'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 12.0),
                              Text(
                                error,
                                style: const TextStyle(
                                    color: CupertinoColors.systemRed,
                                    fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
