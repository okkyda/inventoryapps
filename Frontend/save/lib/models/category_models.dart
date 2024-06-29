class CategoryModel {
  String? id;
  String? categoryName;
  int? cateNumber;

  CategoryModel({
    this.id,
    this.categoryName,
    this.cateNumber,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'],
      categoryName: json['cateName'],
      cateNumber: json['cateNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'cateName': categoryName,
      'cateNumber': cateNumber,
    };
  }
}
