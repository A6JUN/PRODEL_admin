import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/service_area/service_area_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_card.dart';
import 'package:prodel_admin/values/colors.dart';

import 'custom_alert_dialog.dart';

class ServiceAreaSelector extends StatefulWidget {
  final Function(int) onSelect;
  final int selectedDepartment;
  const ServiceAreaSelector({
    super.key,
    required this.onSelect,
    this.selectedDepartment = 0,
  });

  @override
  State<ServiceAreaSelector> createState() => _ServiceAreaSelectorState();
}

class _ServiceAreaSelectorState extends State<ServiceAreaSelector> {
  final ServiceAreaBloc serviceAreaBloc = ServiceAreaBloc();

  @override
  void initState() {
    serviceAreaBloc.add(GetAllServiceAreaEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocProvider<ServiceAreaBloc>.value(
        value: serviceAreaBloc,
        child: BlocConsumer<ServiceAreaBloc, ServiceAreaState>(
          listener: (context, state) {
            if (state is ServiceAreaFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed!',
                  message: state.message,
                  primaryButtonLabel: 'Retry',
                  primaryOnPressed: () {
                    serviceAreaBloc.add(GetAllServiceAreaEvent());
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ServiceAreaSuccessState) {
              return DropdownMenu(
                hintText: 'All Departments',
                initialSelection: widget.selectedDepartment,
                onSelected: (value) {
                  widget.onSelect(value);
                },
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                dropdownMenuEntries: [
                  const DropdownMenuEntry(
                    value: 0,
                    label: 'All Departments',
                  ),
                  ...List<DropdownMenuEntry>.generate(
                    state.serviceAreas.length,
                    (index) => DropdownMenuEntry(
                      value: state.serviceAreas[index]['id'],
                      label: state.serviceAreas[index]['name'],
                    ),
                  ),
                ],
              );
            } else if (state is ServiceAreaFailureState) {
              return const SizedBox();
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
