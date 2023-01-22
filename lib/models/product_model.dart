/// This is the Model class for Product Information

class ProductModel {
  String? productName;
  String? productImage;
  int? productPrice;
  String? productId;
  int? productQuantity;
  String? productUnit;
  bool? isVegDish;
  bool? isBestseller;
  String? productDescription;
  ProductModel(
      {this.productQuantity,
      this.productId,
      this.productUnit,
      this.productImage,
      this.productName,
      this.productPrice,
      this.isBestseller,
      this.isVegDish,
      this.productDescription});
}
