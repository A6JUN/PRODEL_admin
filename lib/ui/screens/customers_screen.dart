import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
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
              'Customers',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 165, 163, 163),
              height: 30,
            ),
            Expanded(
              child: DataTable2(
                columns: const [
                  DataColumn2(
                    label: Text(
                      "ID",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                  DataColumn2(
                    label: Text(
                      "Name",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  10,
                  (index) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          index.toString(),
                        ),
                      ),
                      const DataCell(
                        Text(
                          "Item",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
