import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/product/product_bloc.dart';
import 'package:prodel_admin/ui/screens/product_images.dart';
import 'package:prodel_admin/ui/widgets/category_selector.dart';
import 'package:prodel_admin/ui/widgets/custom_action_button.dart';
import 'package:prodel_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:prodel_admin/ui/widgets/custom_search.dart';
import 'package:prodel_admin/ui/widgets/product/show_shop_dialog.dart';
import 'package:prodel_admin/ui/widgets/shop_selector.dart';
import 'package:prodel_admin/values/colors.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductBloc productBloc = ProductBloc();
  int? categoryId;

  @override
  void initState() {
    productBloc.add(GetAllProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>.value(
      value: productBloc,
      child: Center(
        child: SizedBox(
          width: 1000,
          child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductFailureState) {
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
                  Text(
                    'Products',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: CustomSearch(
                            onSearch: (search) {
                              productBloc.add(GetAllProductsEvent(
                                query: search,
                              ));
                            },
                          ),
                        ),
                        const VerticalDivider(),
                        CategorySelector(
                          onSelect: (id) {
                            productBloc.add(
                              GetAllProductsEvent(
                                categoryId: id == 0 ? null : id,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ShopSelector(
                          onSelect: (id) {
                            productBloc.add(
                              GetAllProductsEvent(
                                shopId: id == 0 ? null : id,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 165, 163, 163),
                    height: 30,
                  ),
                  state is ProductLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : state is ProductSuccessState
                          ? state.products.isNotEmpty
                              ? Expanded(
                                  child: DataTable2(
                                    columnSpacing: 10,
                                    horizontalMargin: 10,
                                    dataRowHeight: 90,
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
                                        size: ColumnSize.L,
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
                                          "Description",
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
                                        size: ColumnSize.S,
                                        label: Text(
                                          "Category",
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
                                        size: ColumnSize.S,
                                        label: Text(
                                          "Price",
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
                                        size: ColumnSize.S,
                                        label: Text(
                                          "Disc.Price",
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
                                        size: ColumnSize.S,
                                        label: Text(
                                          "Measure.",
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
                                        size: ColumnSize.S,
                                        label: Text(
                                          "Qty",
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
                                      state.products.length,
                                      (index) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              state.products[index]['id']
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.products[index]['name'],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.products[index]
                                                  ['description'],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.products[index]['category']
                                                  ['name'],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '₹${state.products[index]['price'].toString()}',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '₹${state.products[index]['discounted_price'].toString()}',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.products[index]
                                                  ['measurement'],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.products[index]['quantity'],
                                            ),
                                          ),
                                          DataCell(
                                            Wrap(
                                              spacing: 10,
                                              runSpacing: 10,
                                              children: [
                                                CustomActionButton(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  label: 'Shop',
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          ShowShopDialog(
                                                        shopDetails: state
                                                                .products[index]
                                                            ['shop'],
                                                      ),
                                                    );
                                                  },
                                                  color: Colors.purple,
                                                ),
                                                CustomActionButton(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  label: 'Images',
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductImagesScreen(
                                                          images: state
                                                                  .products[
                                                              index]['images'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                CustomActionButton(
                                                  iconData:
                                                      state.products[index]
                                                                  ['status'] ==
                                                              'active'
                                                          ? Icons.block_outlined
                                                          : Icons.done_sharp,
                                                  onPressed: () {
                                                    productBloc.add(
                                                      ChangeProductStatusEvent(
                                                        productId: state
                                                                .products[index]
                                                            ['id'],
                                                        status: state.products[
                                                                        index][
                                                                    'status'] ==
                                                                'active'
                                                            ? 'ban'
                                                            : 'active',
                                                      ),
                                                    );
                                                  },
                                                  color: state.products[index]
                                                              ['status'] ==
                                                          'active'
                                                      ? Colors.red
                                                      : Colors.green,
                                                  label: state.products[index]
                                                              ['status'] ==
                                                          'active'
                                                      ? 'Ban'
                                                      : 'Activate',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const Center(child: Text('No products found !'))
                          : state is ProductFailureState
                              ? Center(
                                  child: CustomActionButton(
                                    onPressed: () {
                                      productBloc.add(GetAllProductsEvent());
                                    },
                                    label: 'Retry',
                                    iconData: Icons.refresh_outlined,
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                )
                              : const SizedBox(),
                  const SizedBox(
                    height: 40,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
