import 'package:flutter/material.dart';
import 'package:save/models/product_item.dart';
import 'package:save/models/product_models.dart';
import 'package:save/pages/home_page.dart';
import 'package:save/services/api_services.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductModel> products = []; // List kosong untuk menyimpan produk

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Panggil fungsi untuk mengambil produk dari API

    // Dummy data untuk ditambahkan ke dalam list produk
    products.addAll([
      ProductModel(
        id: "1",
        productName: "Haldiram",
        productQty: 500,
        productUrl:
            "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=85,metadata=none,w=400,h=400/app/images/products/full_screen/pro_86973.jpg",
      ),
      ProductModel(
        id: "2",
        productName: "Product 2",
        productQty: 300,
        productUrl: "https://dummyimage.com/300x300/000/fff",
      ),
      ProductModel(
        id: "3",
        productName: "Product 3",
        productQty: 200,
        productUrl: "https://dummyimage.com/300x300/000/fff",
      ),
    ]);
  }

  void fetchProducts() async {
    try {
      // Panggil fungsi getProducts dari APIService
      List<ProductModel>? fetchedProducts = await APIService.getProducts();

      if (fetchedProducts != null) {
        setState(() {
          products = fetchedProducts;
        });
      } else {
        print("Failed to fetch products.");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Widget productList(List<ProductModel> products) {
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
              Navigator.pushNamed(context, "/produkadd").then((value) {
                // Setelah kembali dari halaman tambah, ambil data lagi
                fetchProducts();
              });
            },
            child: const Text("Add Product"),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItem(
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
        title: const Text("Products"),
        elevation: 0,
      ),
      backgroundColor: Colors.yellow,
      body: productList(products),
    );
  }
}
