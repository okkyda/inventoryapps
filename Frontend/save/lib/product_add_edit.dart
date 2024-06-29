import 'package:flutter/material.dart';
import 'package:save/config.dart';
import 'package:save/models/product_models.dart';
import 'package:save/services/api_services.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class ProductAddEdit extends StatefulWidget {
  const ProductAddEdit({super.key});

  @override
  State<ProductAddEdit> createState() => _ProductAddEditState();
}

class _ProductAddEditState extends State<ProductAddEdit> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  ProductModel? productModel;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    productModel = ProductModel();
    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
        productModel = arguments["model"];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = isEditMode ? "Edit Data Produk" : "Tambah Data Produk";

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          child: Form(
            key: globalKey,
            child: productForm(),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget productForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "productName",
              "Product Name",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Nama Produk Tidak Boleh Kosong';
                }
                return null;
              },
              (onSavedVal) {
                productModel!.productName = onSavedVal;
              },
              initialValue: productModel!.productName ?? "",
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              prefixIcon: const Icon(Icons.label),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "productQty",
              "Product Qty",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Jumlah Qty Produk Tidak Boleh Kosong';
                }
                if (int.tryParse(onValidateVal) == null) {
                  return 'Jumlah Qty Produk Harus Angka';
                }
                return null;
              },
              (onSavedVal) {
                productModel!.productQty = int.tryParse(onSavedVal);
              },
              initialValue: productModel!.productQty == null
                  ? ""
                  : productModel!.productQty.toString(),
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              prefixIcon: const Icon(Icons.format_list_numbered),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "productUrl",
              "Product Url",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Url Produk Tidak Boleh Kosong';
                }
                return null;
              },
              (onSavedVal) {
                productModel!.productUrl = onSavedVal;
              },
              initialValue: productModel!.productUrl ?? "",
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              prefixIcon: const Icon(Icons.link),
            ),
          ),
          Center(
            child: FormHelper.submitButton(
              "Simpan",
              () {
                if (validateAndSave()) {
                  if (productModel?.productName != null &&
                      productModel?.productQty != null) {
                    setState(() {
                      isApiCallProcess = true;
                    });

                    APIService.saveProduct(productModel!, isEditMode)
                        .then((response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/produks', (route) => false);
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Berhasil",
                          "OK",
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/produks', (route) => false);
                          },
                        );
                      }
                    }).catchError((error) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      print("Error: $error");
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "Error occurred: $error",
                        "OK",
                        () {
                          Navigator.of(context).pop();
                        },
                      );
                    });
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      "Please fill all required fields",
                      "OK",
                      () {
                        Navigator.of(context).pop();
                      },
                    );
                  }
                }
              },
              btnColor: Colors.green,
              borderColor: Colors.white,
              borderRadius: 10,
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      print("Form is valid. Product details:");
      print("Name: ${productModel!.productName}");
      print("Qty: ${productModel!.productQty}");
      print("URL: ${productModel!.productUrl}");
      return true;
    }
    return false;
  }
}
