import 'package:flutter/material.dart';
import 'package:save/models/product_models.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, this.model, this.onDelete}) : super(key: key);

  final ProductModel? model;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              productWidget(context),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model?.productName ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => onDelete?.call(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Qty: ${model?.productQty ?? 0}"),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/produkedit', arguments: {
                        'model': model
                      },);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productWidget(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          height: 70,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          child: Image.network(
            (model!.productUrl == null || model!.productUrl == "")
                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                : model!.productUrl!,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        // Expanded(
        //   // child: Column(
        //   //   crossAxisAlignment: CrossAxisAlignment.start,
        //   //   children: [
        //   //     Text(
        //   //       model!.productName!,
        //   //       style: const TextStyle(
        //   //         color: Colors.black,
        //   //         fontWeight: FontWeight.bold,
        //   //       ),
        //   //       overflow: TextOverflow.ellipsis,
        //   //     ),
        //   //     const SizedBox(height: 5),
        //   //     Text(
        //   //       "Qty: ${model!.productQty}",
        //   //       style: const TextStyle(color: Colors.black),
        //   //     ),
        //   //   ],
        //   // ),
        // ),
      ],
    );
  }
}
