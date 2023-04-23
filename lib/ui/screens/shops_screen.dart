import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/shop/shop_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_action_button.dart';
import 'package:prodel_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:prodel_admin/ui/widgets/custom_icon_button.dart';
import 'package:prodel_admin/ui/widgets/custom_search.dart';
import 'package:prodel_admin/ui/widgets/shops/add_edit_shop_dialog.dart';
import 'package:prodel_admin/values/colors.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  ShopBloc shopBloc = ShopBloc();

  @override
  void initState() {
    shopBloc.add(GetAllShopEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopBloc>.value(
      value: shopBloc,
      child: Center(
        child: SizedBox(
          width: 1200,
          child: BlocConsumer<ShopBloc, ShopState>(
            listener: (context, state) {
              if (state is ShopFailureState) {
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
                        'Shops',
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
                            builder: (context) => BlocProvider<ShopBloc>.value(
                              value: shopBloc,
                              child: const AddEditShopDialog(),
                            ),
                          );
                        },
                        label: 'Add Shop',
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
                      shopBloc.add(
                        GetAllShopEvent(
                          query: search,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 165, 163, 163),
                    height: 30,
                  ),
                  Expanded(
                    child: state is ShopLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : state is ShopSuccessState
                            ? state.shops.isNotEmpty
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
                                        size: ColumnSize.S,
                                        label: Text(
                                          "Image",
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
                                          "Address",
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
                                          "Service Area",
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
                                          "Pin",
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
                                      state.shops.length,
                                      (index) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              state.shops[index]['shop']['id']
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            CachedNetworkImage(
                                              imageUrl: state.shops[index]
                                                  ['shop']['image_url'],
                                              height: 45,
                                              width: 45,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.shops[index]['shop']
                                                  ['name'],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '${state.shops[index]['shop']['address_line']}, ${state.shops[index]['shop']['place']}, ${state.shops[index]['shop']['city']}',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.shops[index]['area']['name']
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.shops[index]['shop']['pin']
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              spacing: 15,
                                              children: [
                                                CustomIconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          BlocProvider<
                                                              ShopBloc>.value(
                                                        value: shopBloc,
                                                        child:
                                                            AddEditShopDialog(
                                                          shopDetails: state
                                                              .shops[index],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  iconData: Icons.edit_outlined,
                                                ),
                                                CustomIconButton(
                                                  onPressed: () {
                                                    shopBloc.add(
                                                      DeleteShopEvent(
                                                        userId: state
                                                                .shops[index]
                                                            ['shop']['user_id'],
                                                      ),
                                                    );
                                                  },
                                                  color: Colors.red,
                                                  iconData: Icons
                                                      .delete_forever_outlined,
                                                ),
                                                CustomActionButton(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  label: state.shops[index]
                                                                  ['shop']
                                                              ['status'] ==
                                                          'active'
                                                      ? 'Block'
                                                      : 'UnBlock',
                                                  onPressed: () {
                                                    shopBloc.add(
                                                      ChangeShopStatusEvent(
                                                        userId: state
                                                                .shops[index]
                                                            ['shop']['user_id'],
                                                        status: state.shops[index]
                                                                        ['shop']
                                                                    [
                                                                    'status'] ==
                                                                'active'
                                                            ? 'blocked'
                                                            : 'active',
                                                      ),
                                                    );
                                                  },
                                                  color: state.shops[index]
                                                                  ['shop']
                                                              ['status'] ==
                                                          'active'
                                                      ? Colors.red
                                                      : Colors.green,
                                                  iconData:
                                                      Icons.block_outlined,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const Center(child: Text('No shops found !'))
                            : state is ShopFailureState
                                ? Center(
                                    child: CustomActionButton(
                                      onPressed: () {
                                        shopBloc.add(GetAllShopEvent());
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
