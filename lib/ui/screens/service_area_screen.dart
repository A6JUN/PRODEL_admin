import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/service_area/service_area_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_action_button.dart';
import 'package:prodel_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:prodel_admin/ui/widgets/custom_search.dart';
import 'package:prodel_admin/ui/widgets/service_area/add_service_area_dialog.dart';
import 'package:prodel_admin/values/colors.dart';

class ServiceAreaScreen extends StatefulWidget {
  const ServiceAreaScreen({super.key});

  @override
  State<ServiceAreaScreen> createState() => _ServiceAreaScreenState();
}

class _ServiceAreaScreenState extends State<ServiceAreaScreen> {
  ServiceAreaBloc serviceAreaBloc = ServiceAreaBloc();

  @override
  void initState() {
    serviceAreaBloc.add(GetAllServiceAreaEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceAreaBloc>.value(
      value: serviceAreaBloc,
      child: Center(
        child: SizedBox(
          width: 1000,
          child: BlocConsumer<ServiceAreaBloc, ServiceAreaState>(
            listener: (context, state) {
              if (state is ServiceAreaFailureState) {
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
                        'Service Area',
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
                            builder: (context) =>
                                BlocProvider<ServiceAreaBloc>.value(
                              value: serviceAreaBloc,
                              child: const AddServiceAreaDialog(),
                            ),
                          );
                        },
                        label: 'Add Service Area',
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
                      serviceAreaBloc.add(
                        GetAllServiceAreaEvent(
                          query: search,
                        ),
                      );
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 165, 163, 163),
                    height: 30,
                  ),
                  Expanded(
                    child: state is ServiceAreaLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : state is ServiceAreaSuccessState
                            ? state.serviceAreas.isNotEmpty
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
                                        size: ColumnSize.M,
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
                                      state.serviceAreas.length,
                                      (index) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              state.serviceAreas[index]['id']
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.serviceAreas[index]['name'],
                                            ),
                                          ),
                                          DataCell(
                                            CustomActionButton(
                                              mainAxisSize: MainAxisSize.min,
                                              onPressed: () {
                                                serviceAreaBloc.add(
                                                  DeleteServiceAreaEvent(
                                                    areaId: state
                                                            .serviceAreas[index]
                                                        ['id'],
                                                  ),
                                                );
                                              },
                                              color: Colors.red,
                                              iconData:
                                                  Icons.delete_forever_outlined,
                                              label: 'Delete',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text('No service area found !'))
                            : state is ServiceAreaFailureState
                                ? Center(
                                    child: CustomActionButton(
                                      onPressed: () {
                                        serviceAreaBloc
                                            .add(GetAllServiceAreaEvent());
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
