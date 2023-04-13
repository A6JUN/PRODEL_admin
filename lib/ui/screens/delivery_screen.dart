import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:prodel_admin/ui/widgets/custom_action_button.dart';
import 'package:prodel_admin/ui/widgets/custom_search.dart';
import 'package:prodel_admin/ui/widgets/orders/order_status_item.dart';
import 'package:prodel_admin/values/colors.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  OrderStatus orderStatus = OrderStatus.pending;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Orders',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                IconButton(
                  onPressed: () {
                    isExpanded = !isExpanded;
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.sort,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            isExpanded
                ? AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        CustomSearch(
                          hintText: 'Search for order using #ID',
                          onSearch: (search) {},
                        ),
                      ],
                    ),
                    // TODO add sorting buttons (user, shop)
                  )
                : const SizedBox(),
            SizedBox(
              height: isExpanded ? 10 : 0,
            ),
            Row(
              children: [
                OrderStatusItem(
                  iconData: Icons.pending_actions_outlined,
                  isSelected: orderStatus == OrderStatus.pending,
                  label: 'Pending',
                  onTap: () {
                    orderStatus = OrderStatus.pending;
                    setState(() {});
                  },
                  orderStatus: orderStatus == OrderStatus.pending
                      ? OrderStatus.pending
                      : null,
                ),
                const SizedBox(
                  width: 15,
                ),
                OrderStatusItem(
                  iconData: Icons.local_shipping_outlined,
                  isSelected: orderStatus == OrderStatus.packed,
                  label: 'Packed',
                  onTap: () {
                    orderStatus = OrderStatus.packed;
                    setState(() {});
                  },
                  orderStatus: orderStatus == OrderStatus.packed
                      ? OrderStatus.packed
                      : null,
                ),
                const SizedBox(
                  width: 15,
                ),
                OrderStatusItem(
                  iconData: Icons.done_all_outlined,
                  isSelected: orderStatus == OrderStatus.complete,
                  label: 'Completed',
                  onTap: () {
                    orderStatus = OrderStatus.complete;
                    setState(() {});
                  },
                  orderStatus: orderStatus == OrderStatus.complete
                      ? OrderStatus.complete
                      : null,
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 165, 163, 163),
              height: 30,
            ),
            Expanded(
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                columns: [
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "#ID",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Customer",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Shop",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Total Price (₹)",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Date",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.L,
                    label: Text(
                      "Actions",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  20,
                  (index) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          index.toString(),
                        ),
                      ),
                      const DataCell(
                        Text(
                          "Amal",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "New shop",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "20000",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "12/12/2022",
                        ),
                      ),
                      DataCell(
                        Wrap(
                          children: [
                            CustomActionButton(
                              mainAxisSize: MainAxisSize.min,
                              label: 'Products',
                              onPressed: () {},
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomActionButton(
                              mainAxisSize: MainAxisSize.min,
                              label: 'Customer',
                              onPressed: () {},
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomActionButton(
                              mainAxisSize: MainAxisSize.min,
                              label: 'Shop',
                              onPressed: () {},
                              color: Colors.teal,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
