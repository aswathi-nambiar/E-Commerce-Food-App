/// This is the Model class for Cart Items

class ReviewCartModel {
  String? cartId;
  String? cartImage;
  String? cartName;
  int? cartPrice;
  int? cartQuantity;
  dynamic cartUnit;
  ReviewCartModel({
    this.cartId,
    this.cartUnit,
    this.cartImage,
    this.cartName,
    this.cartPrice,
    this.cartQuantity,
  });
}
