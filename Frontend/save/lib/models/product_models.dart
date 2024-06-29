class ProductModel {
  String? id;
  String? productName;
  int? productQty;
  //int? productCategoryId;
  String? productUrl;
  

  ProductModel({
    this.id,
    this.productName,
    this.productQty,
    //this.productCategoryId,
    this.productUrl,
    
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      productName: json["productName"],
      productQty: json["productQty"],
      // productCategoryId: json["productCategoryId"],
      productUrl: json["productUrl"],
      
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["productName"] = this.productName;
    data["productQty"] = this.productQty;
    // data["productCategoryId"] = this.productCategoryId;
    data["productUrl"] = this.productUrl;
    
    return data;
  }
}

List<ProductModel> productsFromJson(dynamic str) =>
    List<ProductModel>.from((str).map((x) => ProductModel.fromJson(x)));
