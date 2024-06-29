import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:save/models/product_models.dart';
import 'package:uuid/uuid.dart';
import 'package:save/config.dart';
import 'package:save/models/category_models.dart';
import 'package:save/models/login_request_model.dart';
import 'package:save/models/login_response_model.dart';
import 'package:save/models/register_request_model.dart';
import 'package:save/models/register_response_model.dart';
import 'package:save/services/shared_service.dart';

class APIService {
  static var client = http.Client();

  // Login API
  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  // Register API
  static Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(response.body);
  }

  // Get user profile API
  static Future<String> getUserProfile() async {
    var requestHeaders = await getAuthHeaders();
    var url = Uri.http(Config.apiURL, Config.userProfileAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  // Get all categories API
  static Future<List<CategoryModel>?> getCategories() async {
  try {
    var requestHeaders = await getAuthHeaders();
    var url = Uri.http(Config.apiURL, '/categories/all'); // Sesuaikan URL

    print("Request URL: $url");
    print("Request Headers: $requestHeaders");

    var response = await client.get(url, headers: requestHeaders);

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['data'] is List) {
        return jsonData['data'].map<CategoryModel>((item) => CategoryModel.fromJson(item)).toList();
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Failed to fetch categories: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching categories: $e");
    return null;
  }
}



  // Get all products API
  static Future<List<ProductModel>?> getProducts() async {
  try {
    var requestHeaders = await getAuthHeaders();
    var url = Uri.http(Config.apiURL, '/products/all'); // Sesuaikan URL

    print("Request URL: $url");
    print("Request Headers: $requestHeaders");

    var response = await client.get(url, headers: requestHeaders);

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['data'] is List) {
        return jsonData['data'].map<ProductModel>((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Failed to fetch categories: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching categories: $e");
    return null;
  }
}

  // Save product API (POST or PUT)
  static Future<bool> saveProduct(ProductModel model, bool isEditMode) async {
    try {
      var productURL = Config.productAPI;

      if (isEditMode) {
        productURL = '$productURL/${model.id.toString()}';
      }

      var url = Uri.http(Config.apiURL, productURL);
      var requestMethod = isEditMode ? "PUT" : "POST";

      var requestHeaders = await getAuthHeaders();

      var request = http.MultipartRequest(requestMethod, url);
      request.headers.addAll(requestHeaders);

      if (model.productName != null && model.productQty != null) {
        request.fields['productName'] = model.productName!;
        request.fields['productQty'] = model.productQty!.toString();

        if (model.productUrl != null) {
          request.fields['productUrl'] = model.productUrl!;
        }

        var response = await request.send();

        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception("Product data is incomplete");
      }
    } catch (e) {
      print("Error saving product: $e");
      return false;
    }
  }

  // Delete product API
  static Future<bool> deleteProduct(String productId) async {
    try {
      var requestHeaders = await getAuthHeaders();
      var url = Uri.http(Config.apiURL, '${Config.productAPI}/$productId');

      var response = await client.delete(url, headers: requestHeaders);

      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting product: $e");
      return false;
    }
  }

 // Save category API (POST or PUT)
static Future<bool> saveCategory(CategoryModel model, bool isEditMode) async {
  try {
    var categoryURL = Config.categoryAPI;

    if (!isEditMode && (model.id == null || model.id!.isEmpty)) {
      model.id = Uuid().v4();
    }

    if (isEditMode) {
      categoryURL = '$categoryURL/update/${model.id.toString()}';
    } else {
      categoryURL = '$categoryURL';
    }

    var url = Uri.http(Config.apiURL, categoryURL);
    var requestMethod = isEditMode ? "PUT" : "POST";

    var requestHeaders = await getAuthHeaders();

    var response = await (isEditMode
        ? client.put(url, headers: requestHeaders, body: jsonEncode(model.toJson()))
        : client.post(url, headers: requestHeaders, body: jsonEncode(model.toJson())));

    if (response.statusCode == 200) {
      // Berhasil menyimpan kategori, tampilkan pesan sukses atau lakukan navigasi
      print("Category saved successfully.");
      return true;
    } else {
      // Gagal menyimpan kategori, tampilkan pesan kesalahan dari server
      print("Error saving category: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    // Tangani error ketika menyimpan kategori
    print("Error saving category: $e");
    return false;
  }
}


  // Delete category API
  static Future<bool> deleteCategory(String categoryId) async {
    try {
      var requestHeaders = await getAuthHeaders();
      var url = Uri.http(Config.apiURL, '${Config.categoryAPI}/delete/$categoryId');

      var response = await client.delete(url, headers: requestHeaders);

      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting category: $e");
      return false;
    }
  }

  // Get authorization headers
  static Future<Map<String, String>> getAuthHeaders() async {
    var loginDetails = await SharedService.loginDetails();
    if (loginDetails != null) {
      return {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${loginDetails.data.token}'
      };
    } else {
      return {
        'Content-Type': 'application/json',
      };
    }
  }
}
