import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:prodel_admin/ui/widgets/custom_action_button.dart';
import 'package:prodel_admin/ui/widgets/custom_search.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
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
            CustomSearch(
              onSearch: (search) {},
            ),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 165, 163, 163),
              height: 50,
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
                    size: ColumnSize.M,
                    label: Text(
                      "Name",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.M,
                    label: Text(
                      "Description",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Category",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Price",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Disc.Price",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Measure.",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Qty",
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
                          "Some product",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "Product descrption ddfhdfkjdfdsg",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "Electronics",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "₹20000",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "₹10000",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "KG",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "10",
                        ),
                      ),
                      DataCell(
                        Wrap(
                          spacing: 10,
                          children: [
                            CustomActionButton(
                              mainAxisSize: MainAxisSize.min,
                              label: 'Images',
                              onPressed: () {},
                            ),
                            CustomActionButton(
                              mainAxisSize: MainAxisSize.min,
                              label: 'Ban',
                              onPressed: () {},
                              color: Colors.red,
                              iconData: Icons.block_flipped,
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
            )
          ],
        ),
      ),
    );
  }
}
