import 'package:flutter/material.dart';
import 'package:save/config.dart';
import 'package:save/models/category_models.dart';
import 'package:save/services/api_services.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:uuid/uuid.dart';

class CategoryAddEdit extends StatefulWidget {
  const CategoryAddEdit({super.key});

  @override
  State<CategoryAddEdit> createState() => _CategoryAddEditState();
}

class _CategoryAddEditState extends State<CategoryAddEdit> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  CategoryModel? categoryModel;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    categoryModel = CategoryModel();
    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
        categoryModel = arguments["model"];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle =
        isEditMode ? "Edit Data Kategori" : "Tambah Data Kategori";

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
            child: categoryForm(),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget categoryForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "cateName",
              "Category Name",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Nama Kategori Tidak Boleh Kosong';
                }
                return null;
              },
              (onSavedVal) {
                categoryModel!.categoryName = onSavedVal;
              },
              initialValue: categoryModel!.categoryName ?? "",
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
              "cateNumber",
              "Category Number",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Number Tidak Boleh Kosong';
                }
                if (int.tryParse(onValidateVal) == null) {
                  return 'Harus berupa angka';
                }
                return null;
              },
              (onSavedVal) {
                categoryModel!.cateNumber = int.tryParse(onSavedVal);
              },
              initialValue: categoryModel!.cateNumber?.toString() ?? "",
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              prefixIcon: const Icon(Icons.confirmation_number),
            ),
          ),
          Center(
            child: FormHelper.submitButton(
              "Simpan",
              () {
                if (validateAndSave()) {
                  if (!isEditMode &&
                      (categoryModel!.id == null ||
                          categoryModel!.id!.isEmpty)) {
                    categoryModel!.id = Uuid().v4();
                  }

                  print(categoryModel!.toJson());

                  setState(() {
                    isApiCallProcess = true;
                  });

                  APIService.saveCategory(
                    categoryModel!,
                    isEditMode,
                  ).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/cate',
                          (route) => false,
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Berhasil",
                          "OK",
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/cate', (route) => false);
                          },
                        );
                      }
                    },
                  );
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
      return true;
    }
    return false;
  }
}
