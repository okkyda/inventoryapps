import 'package:flutter/material.dart';
import 'package:save/models/category_item.dart';
import 'package:save/models/category_models.dart';
import 'package:save/services/api_services.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<CategoryModel> categories = List<CategoryModel>.empty(growable: true);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    var fetchedCategories = await APIService.getCategories();
    if (fetchedCategories != null) {
      setState(() {
        categories = fetchedCategories;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle error scenario
      print("Error fetching categories");
    }
  }

  Widget productList(List<CategoryModel> products) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              minimumSize: const Size(88, 36),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/categoryadd");
            },
            child: const Text("Add Category"),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return CategoryItem(
                model: products[index],
                onDelete: () {
                  setState(() {
                    products.removeAt(index);
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        elevation: 0,
      ),
      backgroundColor: Colors.yellow,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : productList(categories),
    );
  }
}
