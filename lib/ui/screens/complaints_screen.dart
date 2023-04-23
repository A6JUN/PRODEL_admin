import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/complaints/complaints_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_action_button.dart';
import 'package:prodel_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:prodel_admin/values/colors.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  ComplaintsBloc complaintsBloc = ComplaintsBloc();

  @override
  void initState() {
    complaintsBloc.add(GetAllComplaintsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComplaintsBloc>.value(
      value: complaintsBloc,
      child: Center(
        child: SizedBox(
          width: 1000,
          child: BlocConsumer<ComplaintsBloc, ComplaintsState>(
            listener: (context, state) {
              if (state is ComplaintFailureState) {
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
                    'Complaints',
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
                    child: state is ComplaintsLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : state is ComplaintsSuccessState
                            ? state.complaints.isNotEmpty
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
                                          "Complaint",
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
                                          "User Name",
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
                                    ],
                                    rows: List<DataRow>.generate(
                                      state.complaints.length,
                                      (index) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              state.complaints[index]
                                                      ['complaint']['id']
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.complaints[index]
                                                  ['complaint']['complaint'],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.complaints[index]['profile']
                                                  ['name'],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.complaints[index]['profile']
                                                  ['phone'],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text('No complaints found !'))
                            : state is ComplaintFailureState
                                ? Center(
                                    child: CustomActionButton(
                                      onPressed: () {
                                        complaintsBloc
                                            .add(GetAllComplaintsEvent());
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
