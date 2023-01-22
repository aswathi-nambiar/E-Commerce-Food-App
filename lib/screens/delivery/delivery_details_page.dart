import 'package:e_commerce_food_app/screens/delivery/single_delivery_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../models/delivery_address_model.dart';

import '../../providers/review_cart_provider.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../order_success.dart';
import 'new_delivery_address.dart';

/// This is the Delivery Details page where the user can view the
/// added addresses and place order.
class DeliveryDetailsPage extends StatefulWidget {
  const DeliveryDetailsPage({Key? key}) : super(key: key);

  @override
  State<DeliveryDetailsPage> createState() => _DeliveryDetailsPageState();
}

class _DeliveryDetailsPageState extends State<DeliveryDetailsPage> {
  ReviewCartProvider? reviewCartProvider;
  String error = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);
    reviewCartProvider.getDeliveryAddressData();
  }

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
          middle: const Text('Delivery Details'),
        ),
        child:
            Consumer<ReviewCartProvider>(builder: (_, reviewCartProvider, __) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select an address',
                  style: orderSuccessMessageStyle,
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  child: Text(
                    '+ Add Address',
                    style: addAddressLabelStyle,
                  ),
                  onTap: () async {
                    /// Navigate to Add delivery Details Page

                    await Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                        builder: (context) => const NewDeliveryAddressPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 25,
                ),

                /// list of address
                reviewCartProvider.getDeliveryAddressList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount:
                              reviewCartProvider.getDeliveryAddressList.length,
                          itemBuilder: (context, index) {
                            DeliveryAddressModel? data = reviewCartProvider
                                .getDeliveryAddressList[index];

                            return GestureDetector(
                              onTap: () {
                                reviewCartProvider.updateSelectedAddressValue(
                                    index, data);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: (index ==
                                          reviewCartProvider
                                              .selectedAddressIndex)
                                      ? greyColor.withOpacity(0.2)
                                      : whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SingleDeliveryItem(
                                  address:
                                      "House No: ${data.houseNumber}, Street: ${data.street}, City: ${data.city} Pincode: ${data.pinCode}",
                                  title: "${data.firstName} ",
                                  number: data.mobileNo,
                                  addressType:
                                      data.isHomeAddress ? "Home" : "Work",
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          ' Kindly add an address to place an order',
                          style: emptyAddressDataMessageStyle,
                        ),
                      ),

                Visibility(
                  visible: reviewCartProvider.getDeliveryAddressList.isNotEmpty,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Widget showing Place Order  button
                      Expanded(
                        flex: 2,
                        child: CupertinoButton(
                          color: primaryColor,
                          onPressed: () async {
                            if (reviewCartProvider.userSelectedAddress !=
                                null) {
                              String? cartId = reviewCartProvider
                                  .getReviewCartDataList.first?.cartId;
                              String orderId =
                                  cartId! + DateTime.now().toString();
                              await reviewCartProvider.addPlaceOderData(
                                  orderId: orderId,
                                  address:
                                      reviewCartProvider.userSelectedAddress);

                              bool isSuccess =
                                  await reviewCartProvider.isOrderPlacedSuccess(
                                orderId,
                              );

                              if (isSuccess != true) {
                                setState(() {
                                  error = 'Error in placing order';
                                });
                              } else {
                                if (!mounted) return;

                                /// Navigate to success Page
                                Navigator.of(context, rootNavigator: true).push(
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const OrderSuccessPage()),
                                );
                              }
                            }
                          },
                          child: const Text('Place Order'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  error,
                  style: const TextStyle(
                      color: CupertinoColors.systemRed, fontSize: 14.0),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
