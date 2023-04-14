import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/customer/customer_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_action_button.dart';
import 'package:prodel_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:prodel_admin/ui/widgets/custom_search.dart';
import 'package:prodel_admin/values/colors.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  CustomerBloc customerBloc = CustomerBloc();

  @override
  void initState() {
    customerBloc.add(
      GetAllCustomersEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomerBloc>.value(
      value: customerBloc,
      child: Center(
        child: SizedBox(
          width: 1000,
          child: BlocConsumer<CustomerBloc, CustomerState>(
            listener: (context, state) {
              if (state is CustomerFailureState) {
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
                    'Customers',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomSearch(
                    onSearch: (search) {
                      customerBloc.add(GetAllCustomersEvent(
                        query: search,
                      ));
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 165, 163, 163),
                    height: 30,
                  ),
                  Expanded(
                    child: state is CustomerLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : state is CustomerSuccessState
                            ? state.customers.isNotEmpty
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
                                        size: ColumnSize.S,
                                        label: Text(
                                          "Phone",
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
                                          "Email",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      // DataColumn2(
                                      //   size: ColumnSize.S,
                                      //   label: Text(
                                      //     "Status",
                                      //     style: Theme.of(context)
                                      //         .textTheme
                                      //         .titleMedium!
                                      //         .copyWith(
                                      //           color: Colors.black,
                                      //           fontWeight: FontWeight.w500,
                                      //         ),
                                      //   ),
                                      // ),
                                      // DataColumn2(
                                      //   size: ColumnSize.L,
                                      //   label: Text(
                                      //     "Actions",
                                      //     style: Theme.of(context)
                                      //         .textTheme
                                      //         .titleMedium!
                                      //         .copyWith(
                                      //           color: Colors.black,
                                      //           fontWeight: FontWeight.w500,
                                      //         ),
                                      //   ),
                                      // ),
                                    ],
                                    rows: List<DataRow>.generate(
                                      state.customers.length,
                                      (index) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              state.customers[index]['id']
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.customers[index]['name'],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.customers[index]['phone'],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.customers[index]['email'],
                                            ),
                                          ),
                                          // DataCell(
                                          //   Text(
                                          //     state.suggestions[index]
                                          //         ['suggestion']['status'],
                                          //   ),
                                          // ),
                                          // DataCell(
                                          //   state.suggestions[index]
                                          //                   ['suggestion']
                                          //               ['status'] ==
                                          //           'pending'
                                          //       ? CustomActionButton(
                                          //           mainAxisSize:
                                          //               MainAxisSize.min,
                                          //           onPressed: () {
                                          //             suggestionsBloc.add(
                                          //               ChangeCustomerStatusEvent(
                                          //                 suggestionId:
                                          //                     state.suggestions[
                                          //                                 index]
                                          //                             [
                                          //                             'suggestion']
                                          //                         ['id'],
                                          //               ),
                                          //             );
                                          //           },
                                          //           color: Colors.blue[900]!,
                                          //           iconData:
                                          //               Icons.done_all_outlined,
                                          //           label: 'Completed',
                                          //         )
                                          //       : const SizedBox(),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text('No customers found !'))
                            : state is CustomerFailureState
                                ? Center(
                                    child: CustomActionButton(
                                      onPressed: () {
                                        customerBloc
                                            .add(GetAllCustomersEvent());
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
