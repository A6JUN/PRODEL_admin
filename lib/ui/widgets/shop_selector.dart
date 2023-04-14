import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/service_area/service_area_bloc.dart';
import 'package:prodel_admin/blocs/shop/shop_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_card.dart';
import 'package:prodel_admin/values/colors.dart';

import 'custom_alert_dialog.dart';

class ShopSelector extends StatefulWidget {
  final Function(int) onSelect;
  final int? selectedShop;
  const ShopSelector({
    super.key,
    required this.onSelect,
    this.selectedShop = 0,
  });

  @override
  State<ShopSelector> createState() => _ShopSelectorState();
}

class _ShopSelectorState extends State<ShopSelector> {
  final ShopBloc shopBloc = ShopBloc();
  @override
  void initState() {
    shopBloc.add(GetAllShopEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopBloc>.value(
      value: shopBloc,
      child: BlocConsumer<ShopBloc, ShopState>(
        listener: (context, state) {
          if (state is ShopFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed!',
                message: state.message,
                primaryButtonLabel: 'Retry',
                primaryOnPressed: () {
                  shopBloc.add(GetAllShopEvent());
                  Navigator.pop(context);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ShopSuccessState) {
            return CustomCard(
              child: DropdownMenu(
                hintText: 'All Shops',
                initialSelection: widget.selectedShop,
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
                    label: 'All Shops',
                  ),
                  ...List<DropdownMenuEntry>.generate(
                    state.shops.length,
                    (index) => DropdownMenuEntry(
                      value: state.shops[index]['shop']['id'],
                      label: state.shops[index]['shop']['name'] ?? 'Nan',
                    ),
                  ),
                ],
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
