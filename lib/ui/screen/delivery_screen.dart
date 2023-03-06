import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Delivery & Pre-Order',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          ),
        ),
        const Divider(
          thickness: 1,
          color: Color.fromARGB(255, 165, 163, 163),
          height: 50,
        ),
        Row(
          children: [
            Expanded(
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      "Shop ID",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Product ID",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "User ID",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Location",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  10,
                  (index) => DataRow(cells: [
                    DataCell(
                      Text(
                        index.toString(),
                      ),
                    ),
                    DataCell(
                      Text(index.toString()),
                    ),
                    DataCell(
                      Text(index.toString()),
                    ),
                    const DataCell(
                      Text(
                        "Location",
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
