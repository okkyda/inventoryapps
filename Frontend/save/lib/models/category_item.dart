import 'package:flutter/material.dart';
import 'package:save/models/category_models.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, this.model, this.onDelete}) : super(key: key);

  final CategoryModel? model;
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
              categoryWidget(context),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model?.categoryName ?? "",
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
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/categoryedit',
                        arguments: {'model': model},
                      );
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

  Widget categoryWidget(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          height: 70,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          child: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
