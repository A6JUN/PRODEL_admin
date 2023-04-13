import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/product_category/product_category_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_action_button.dart';
import 'package:prodel_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:prodel_admin/ui/widgets/custom_search.dart';
import 'package:prodel_admin/ui/widgets/product_category/add_product_category_dialog.dart';
import 'package:prodel_admin/values/colors.dart';

class ProductCategoriesScreen extends StatefulWidget {
  const ProductCategoriesScreen({super.key});

  @override
  State<ProductCategoriesScreen> createState() =>
      _ProductCategoriesScreenState();
}

class _ProductCategoriesScreenState extends State<ProductCategoriesScreen> {
  ProductCategoryBloc productCategoryBloc = ProductCategoryBloc();

  @override
  void initState() {
    productCategoryBloc.add(GetAllProductCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCategoryBloc>.value(
      value: productCategoryBloc,
      child: Center(
        child: SizedBox(
          width: 1000,
          child: BlocConsumer<ProductCategoryBloc, ProductCategoryState>(
            listener: (context, state) {
              if (state is ProductCategoryFailureState) {
                showDialog(
                  context: context,
                  builder: (_) => CustomAlertDialog(
                    message: state.message,
                    title: 'Failure',
                    primaryButtonLabel: 'Ok',
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Categories',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      CustomActionButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                BlocProvider<ProductCategoryBloc>.value(
                              value: productCategoryBloc,
                              child: const AddProductCategoryDialog(),
                            ),
                          );
                        },
                        label: 'Add Category',
                        iconData: Icons.add,
                        color: primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomSearch(
                    onSearch: (search) {
                      productCategoryBloc.add(
                        GetAllProductCategoryEvent(query: search),
                      );
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 165, 163, 163),
                    height: 30,
                  ),
                  Expanded(
                    child: state is ProductCategoryLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : state is ProductCategorySuccessState
                            ? state.productCategories.isNotEmpty
                                ? DataTable2(
                                    columnSpacing: 12,
                                    horizontalMargin: 12,
                                    columns: [
                                      DataColumn2(
                                        size: ColumnSize.S,
                                        label: Text(
                                          "#ID",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.M,
                                        label: Text(
                                          "Name",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.L,
                                        label: Text(
                                          "Actions",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                    rows: List<DataRow>.generate(
                                      state.productCategories.length,
                                      (index) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              state.productCategories[index]
                                                      ['id']
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.productCategories[index]
                                                  ['name'],
                                            ),
                                          ),
                                          DataCell(
                                            CustomActionButton(
                                              mainAxisSize: MainAxisSize.min,
                                              onPressed: () {
                                                productCategoryBloc.add(
                                                  DeleteProductCategoryEvent(
                                                    productCategoryId:
                                                        state.productCategories[
                                                            index]['id'],
                                                  ),
                                                );
                                              },
                                              color: Colors.red,
                                              iconData:
                                                  Icons.delete_forever_outlined,
                                              label: 'Delete',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child:
                                        Text('No product categories found !'))
                            : state is ProductCategoryFailureState
                                ? Center(
                                    child: CustomActionButton(
                                      onPressed: () {
                                        productCategoryBloc.add(
                                          GetAllProductCategoryEvent(),
                                        );
                                      },
                                      label: 'Retry',
                                      iconData: Icons.refresh_outlined,
                                      mainAxisSize: MainAxisSize.min,
                                    ),
                                  )
                                : const SizedBox(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
