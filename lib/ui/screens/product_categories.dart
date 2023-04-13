import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:prodel_admin/ui/widgets/custom_action_button.dart';
import 'package:prodel_admin/ui/widgets/custom_search.dart';
import 'package:prodel_admin/values/colors.dart';

class ProductCategoriesScreen extends StatefulWidget {
  const ProductCategoriesScreen({super.key});

  @override
  State<ProductCategoriesScreen> createState() =>
      _ProductCategoriesScreenState();
}

class _ProductCategoriesScreenState extends State<ProductCategoriesScreen> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Product Categories',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                CustomActionButton(
                  onPressed: () {},
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
              onSearch: (search) {},
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
                      "Category Name",
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
                          "Electronics",
                        ),
                      ),
                      DataCell(
                        CustomActionButton(
                          mainAxisSize: MainAxisSize.min,
                          label: 'Delete',
                          onPressed: () {},
                          color: Colors.red,
                          iconData: Icons.delete_forever_outlined,
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
