import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/product_category/product_category_bloc.dart';
import 'package:prodel_admin/blocs/service_area/service_area_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_card.dart';
import 'package:prodel_admin/values/colors.dart';

import 'custom_alert_dialog.dart';

class CategorySelector extends StatefulWidget {
  final Function(int) onSelect;
  final int? selectedCategory;
  const CategorySelector({
    super.key,
    required this.onSelect,
    this.selectedCategory,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final ProductCategoryBloc productCategoryBloc = ProductCategoryBloc();
  @override
  void initState() {
    productCategoryBloc.add(GetAllProductCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCategoryBloc>.value(
      value: productCategoryBloc,
      child: BlocConsumer<ProductCategoryBloc, ProductCategoryState>(
        listener: (context, state) {
          if (state is ProductCategoryFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed!',
                message: state.message,
                primaryButtonLabel: 'Retry',
                primaryOnPressed: () {
                  productCategoryBloc.add(GetAllProductCategoryEvent());
                  Navigator.pop(context);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductCategorySuccessState) {
            return CustomCard(
              child: DropdownMenu(
                hintText: 'All Category',
                initialSelection: widget.selectedCategory,
                onSelected: (value) {
                  widget.onSelect(value);
                },
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                dropdownMenuEntries: [
                  const DropdownMenuEntry(
                    value: 0,
                    label: 'All Category',
                  ),
                  ...List<DropdownMenuEntry>.generate(
                    state.productCategories.length,
                    (index) => DropdownMenuEntry(
                      value: state.productCategories[index]['id'],
                      label: state.productCategories[index]['name'],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ServiceAreaFailureState) {
            return const SizedBox();
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
