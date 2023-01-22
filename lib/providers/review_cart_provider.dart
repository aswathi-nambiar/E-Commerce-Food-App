import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/delivery_address_model.dart';
import '../models/review_cart_model.dart';

/// This is the Provider class for the Cart.
class ReviewCartProvider with ChangeNotifier {
  bool isLoading = false;

  /// This function will add the product to cart
  void addReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
    int? cartPrice,
    int? cartQuantity,
    var cartUnit,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .set(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "cartUnit": cartUnit,
        "isAdd": true,
      },
    );
    notifyListeners();
  }

  /// This function will update the product in the cart
  void updateReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
    int? cartPrice,
    int? cartQuantity,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .update(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "isAdd": true,
      },
    );
    getReviewCartData();
    notifyListeners();
  }

  List<ReviewCartModel?> reviewCartDataList = [];

  /// This function get the data of all the items added in the cart
  void getReviewCartData() async {
    List<ReviewCartModel?> newList = [];

    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .get();
    for (var element in reviewCartValue.docs) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        cartId: element.get("cartId"),
        cartImage: element.get("cartImage"),
        cartName: element.get("cartName"),
        cartPrice: element.get("cartPrice"),
        cartQuantity: element.get("cartQuantity"),
        cartUnit: element.get("cartUnit"),
      );
      newList.add(reviewCartModel);
    }
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel?> get getReviewCartDataList {
    return reviewCartDataList;
  }

  /// Returns the total amount of all the products added in the cart
  double getTotalPrice() {
    double total = 0.0;
    for (var element in reviewCartDataList) {
      total += (element?.cartPrice ?? 0) * (element?.cartQuantity ?? 0);
    }
    return total;
  }

  /// Return the updated price of individual items added in the cart based on
  /// the quantity
  getUpdatedProductPrice(int productPrice, int count) {
    if (count == 0) {
      count = 1;
    }
    return productPrice * count;
  }

  /// this function deleted the item from the cart
  reviewCartDataDelete(cartId) {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .delete();
    getReviewCartData();
  }

  /// This field will have all the saved delivery address
  List<DeliveryAddressModel> deliveryAdressList = [];

  /// This function gets all the added address from the Firebase
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    QuerySnapshot deliveryAdddress = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourAddresses")
        .get();

    for (var element in deliveryAdddress.docs) {
      DeliveryAddressModel deliveryAddressModel = DeliveryAddressModel(
        firstName: element.get('name'),
        mobileNo: element.get('mobileNumber'),
        houseNumber: element.get('houseNumber'),
        street: element.get('streetName'),
        landMark: element.get('landMark'),
        area: element.get('area'),
        city: element.get('city'),
        pinCode: element.get('pinCode'),
        isHomeAddress: element.get('isHomeAddress'),
      );
      newList.add(deliveryAddressModel);
    }
    deliveryAdressList = newList;
    if (deliveryAdressList.isNotEmpty) {
      selectedAddress = deliveryAdressList.first;
    }
    notifyListeners();
  }

  /// getter returning the saved delivery addresses
  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }

  /// This function generates the id for delivery address to be saved in firebase
  String generateDeliveryAddressId() {
    int count = 0;
    if (getDeliveryAddressList.isNotEmpty) {
      count = getDeliveryAddressList.length;
    }
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    String id = '$uid$count';
    return id;
  }

  /// This function adds an address to the Firebase
  addDeliveryAddressData({
    required DeliveryAddressModel address,
  }) async {
    isLoading = true;
    String id = generateDeliveryAddressId();

    await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourAddresses")
        .doc(id)
        .set({
      "name": address.firstName,
      "mobileNumber": address.mobileNo,
      "houseNumber": address.houseNumber,
      "streetName": address.street,
      "landMark": address.landMark,
      "city": address.city,
      "area": address.area,
      "pinCode": address.pinCode,
      "isHomeAddress": address.isHomeAddress,
    }).then((value) {
      isLoading = false;
    });
    getDeliveryAddressData();
  }

  int selectedAddressIndex = 0;
  DeliveryAddressModel? selectedAddress;

  /// getter returning the selected address
  get getSelectedAddressValue => selectedAddressIndex;

  get userSelectedAddress => selectedAddress;

  /// function updating the selected address based on the user selection
  updateSelectedAddressValue(int index, DeliveryAddressModel address) {
    selectedAddressIndex = index;
    selectedAddress = address;
    notifyListeners();
  }

  /// this function placed the order. This functions adds the order placed to firebase
  addPlaceOderData({
    required String orderId,
    required DeliveryAddressModel address,
    var shipping,
  }) async {
    isLoading = true;
    FirebaseFirestore.instance
        .collection("Order")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("MyOrders")
        .doc(orderId)
        .set(
      {
        "orderId": orderId,
        "subTotal": getTotalPrice(),
        "orderTime": DateTime.now(),
        "orderItems": getReviewCartDataList
            .map((e) => {
                  "orderImage": e?.cartImage,
                  "orderName": e?.cartName,
                  "orderUnit": e?.cartUnit,
                  "orderPrice": e?.cartPrice,
                  "orderQuantity": e?.cartQuantity
                })
            .toList(),
        "name": address.firstName,
        "mobileNumber": address.mobileNo,
        "houseNumber": address.houseNumber,
        "streetName": address.street,
        "area": address.area,
        "landMark": address.landMark,
        "city": address.city,
        "pinCode": address.pinCode,
        "isHomeAddress": address.isHomeAddress,
      },
    ).then((value) async {
      var collection = FirebaseFirestore.instance
          .collection('ReviewCart')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("YourReviewCart");
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
      isLoading = false;
    });
  }

  /// This functions returns [bool] value. Return true if order is placed successfully
  /// false otherwise
  Future<bool> isOrderPlacedSuccess(String orderId) async {
    isLoading = true;
    bool isAdded = false;

    QuerySnapshot placesOrderList = await FirebaseFirestore.instance
        .collection("Order")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("MyOrders")
        .get();

    for (var element in placesOrderList.docs) {
      if (element.get("orderId") == orderId) {
        isAdded = true;
        isLoading = false;
        continue;
      }
    }
    return isAdded;
  }
}
