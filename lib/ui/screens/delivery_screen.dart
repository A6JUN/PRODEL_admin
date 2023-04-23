import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prodel_admin/blocs/manage_order/manage_order_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_action_button.dart';
import 'package:prodel_admin/ui/widgets/custom_search.dart';
import 'package:prodel_admin/ui/widgets/orders/order_status_item.dart';
import 'package:prodel_admin/values/colors.dart';

import '../widgets/custom_alert_dialog.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  String orderStatus = 'pending';
  final ManageOrderBloc manageOrdersBloc = ManageOrderBloc();

  void getOrders() {
    manageOrdersBloc.add(GetAllOrderEvent(status: orderStatus));
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider<ManageOrderBloc>.value(
        value: manageOrdersBloc,
        child: BlocConsumer<ManageOrderBloc, ManageOrderState>(
          listener: (context, state) {
            if (state is ManageOrderFailureState) {
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
            return SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Orders',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      OrderStatusItem(
                        iconData: Icons.pending_actions_outlined,
                        isSelected: orderStatus == 'pending',
                        label: 'Pending',
                        onTap: () {
                          orderStatus = 'pending';
                          setState(() {});
                          getOrders();
                        },
                        orderStatus:
                            orderStatus == 'pending' ? 'pending' : null,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      OrderStatusItem(
                        iconData: Icons.local_shipping_outlined,
                        isSelected: orderStatus == 'packed',
                        label: 'Packed',
                        onTap: () {
                          orderStatus = 'packed';
                          setState(() {});
                          getOrders();
                        },
                        orderStatus: orderStatus == 'packed' ? 'packed' : null,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      OrderStatusItem(
                        iconData: Icons.done_all_outlined,
                        isSelected: orderStatus == 'complete',
                        label: 'Completed',
                        onTap: () {
                          orderStatus = 'complete';
                          setState(() {});
                          getOrders();
                        },
                        orderStatus:
                            orderStatus == 'complete' ? 'complete' : null,
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 165, 163, 163),
                    height: 30,
                  ),
                  state is ManageOrderSuccessState
                      ? state.orders.isNotEmpty
                          ? Expanded(
                              child: DataTable2(
                                columnSpacing: 12,
                                horizontalMargin: 12,
                                columns: [
                                  DataColumn2(
                                    size: ColumnSize.S,
                                    fixedWidth: 60,
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
                                      "Customer",
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
                                      "Shop",
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
                                      "Total Price (₹)",
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
                                      "Date",
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
                                  state.orders.length,
                                  (index) => DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          state.orders[index]['id'].toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          state.orders[index]['user']['name'],
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          state.orders[index]['shop']['name'],
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          state.orders[index]['total']
                                              .toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          DateFormat('dd/MM/yyyy').format(
                                              DateTime.parse(state.orders[index]
                                                  ['created_at'])),
                                        ),
                                      ),
                                      DataCell(
                                        Wrap(
                                          alignment: WrapAlignment.end,
                                          children: [
                                            CustomActionButton(
                                              mainAxisSize: MainAxisSize.min,
                                              label: 'Products',
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      OrderProductsDialog(
                                                    orderItems: state
                                                        .orders[index]['items'],
                                                  ),
                                                );
                                              },
                                              color: Colors.purple,
                                            ),
                                            // const SizedBox(
                                            //   width: 10,
                                            // ),
                                            // CustomActionButton(
                                            //   mainAxisSize: MainAxisSize.min,
                                            //   label: 'Customer',
                                            //   onPressed: () {},
                                            // ),
                                            // const SizedBox(
                                            //   width: 10,
                                            // ),
                                            // CustomActionButton(
                                            //   mainAxisSize: MainAxisSize.min,
                                            //   label: 'Shop',
                                            //   onPressed: () {},
                                            //   color: Colors.teal,
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const Center(child: Text('No Orders Found'))
                      : const Center(child: CupertinoActivityIndicator()),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrderProductsDialog extends StatelessWidget {
  final List<dynamic> orderItems;
  const OrderProductsDialog({
    super.key,
    required this.orderItems,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 600,
      title: 'Products',
      message: 'Products on the order',
      content: Flexible(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) => Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  index == 0 ? "#ID" : orderItems[index - 1]['id'].toString(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight:
                          index == 0 ? FontWeight.bold : FontWeight.normal),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  index == 0
                      ? "Name"
                      : orderItems[index - 1]['product']['name'],
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight:
                          index == 0 ? FontWeight.bold : FontWeight.normal),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    index == 0
                        ? "Quantity"
                        : orderItems[index - 1]['quantity'].toString(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight:
                            index == 0 ? FontWeight.bold : FontWeight.normal),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    index == 0
                        ? "Price"
                        : orderItems[index - 1]['price'].toString(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight:
                            index == 0 ? FontWeight.bold : FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemCount: orderItems.length + 1,
        ),
      ),
      primaryButtonLabel: 'Ok',
    );
  }
}
