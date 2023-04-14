import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/product_category/product_category_bloc.dart';

import '../custom_button.dart';

class AddProductCategoryDialog extends StatefulWidget {
  const AddProductCategoryDialog({
    super.key,
  });

  @override
  State<AddProductCategoryDialog> createState() =>
      _AddProductCategoryDialogState();
}

class _AddProductCategoryDialogState extends State<AddProductCategoryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          width: 1,
          color: Colors.black26,
        ),
      ),
      child: SizedBox(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add Product Category",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Enter the following details to add a product category.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'product Category Name',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      return null;
                    } else {
                      return 'Please enter product category name';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'eg.Electronics',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  label: 'Add',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ProductCategoryBloc>(context).add(
                        AddProductCategoryEvent(
                          productCategoryName: _nameController.text.trim(),
                        ),
                      );
                    }

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
