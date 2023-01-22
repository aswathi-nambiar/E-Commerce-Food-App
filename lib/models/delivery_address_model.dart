/// This is the Model class for Delivery Address
class DeliveryAddressModel {
  String firstName;
  String mobileNo;
  String houseNumber;
  String street;
  String? landMark;
  String? area;
  String city;
  String pinCode;
  bool isHomeAddress;

  DeliveryAddressModel({
    required this.city,
    required this.firstName,
    this.landMark,
    this.area,
    required this.mobileNo,
    required this.pinCode,
    required this.street,
    required this.houseNumber,
    this.isHomeAddress = true,
  });
}
