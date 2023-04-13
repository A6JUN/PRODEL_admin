import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/service_area/service_area_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_card.dart';
import 'package:prodel_admin/values/colors.dart';

import 'custom_alert_dialog.dart';

class ServiceAreaSelector extends StatefulWidget {
  final Function(int) onSelect;
  final int? selectedServiceArea;
  const ServiceAreaSelector({
    super.key,
    required this.onSelect,
    this.selectedServiceArea,
  });

  @override
  State<ServiceAreaSelector> createState() => _ServiceAreaSelectorState();
}

class _ServiceAreaSelectorState extends State<ServiceAreaSelector> {
  final ServiceAreaBloc serviceAreaBloc = ServiceAreaBloc();
  int? selectedId;
  @override
  void initState() {
    serviceAreaBloc.add(GetAllServiceAreaEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceAreaBloc>.value(
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
            return Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              child: DropdownButton(
                borderRadius: BorderRadius.circular(20),
                isExpanded: true,
                underline: const SizedBox(),
                hint: Text(
                  'Select Service Area',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.black,
                      ),
                ),
                value: selectedId ?? widget.selectedServiceArea,
                onChanged: (value) {
                  widget.onSelect(value);
                  selectedId = value;
                  setState(() {});
                },
                items: List<DropdownMenuItem>.generate(
                  state.serviceAreas.length,
                  (index) => DropdownMenuItem(
                    value: state.serviceAreas[index]['id'],
                    child: Text(
                      state.serviceAreas[index]['name'],
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ),
              ),
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
    );
  }
}
