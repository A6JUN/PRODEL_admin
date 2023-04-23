import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/dashboard_count/dashboard_count_bloc.dart';

import '../widgets/custom_alert_dialog.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardCountBloc dashboardCountBloc = DashboardCountBloc();

  @override
  void initState() {
    super.initState();
    dashboardCountBloc.add(DashboardCountEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider<DashboardCountBloc>.value(
        value: dashboardCountBloc,
        child: BlocConsumer<DashboardCountBloc, DashboardCountState>(
          listener: (context, state) {
            if (state is DashboardCountFailureState) {
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
            return SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        "Dashboard",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 165, 163, 163),
                    height: 30,
                  ),
                  state is DashboardCountSuccessState
                      ? Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            DashboardWidget(
                              iconData: Icons.auto_graph,
                              title: "Total Sales",
                              value: state.dashbordCount['sales'].toString(),
                              color: Color.fromARGB(145, 146, 139, 246),
                            ),
                            DashboardWidget(
                              iconData: Icons.business_outlined,
                              title: "Shops",
                              value:
                                  state.dashbordCount['shops_count'].toString(),
                              color: Color.fromARGB(145, 146, 139, 246),
                            ),
                            DashboardWidget(
                              iconData: Icons.person,
                              title: "Customers",
                              value: state.dashbordCount['profile_count']
                                  .toString(),
                              color: Color.fromARGB(145, 146, 139, 246),
                            ),
                            DashboardWidget(
                              iconData: Icons.auto_graph,
                              title: "Products",
                              value: state.dashbordCount['products_count']
                                  .toString(),
                              color: Color.fromARGB(145, 146, 139, 246),
                            ),
                            DashboardWidget(
                              iconData: Icons.bar_chart,
                              title: "Product Categories",
                              value: state
                                  .dashbordCount['product_categories_count']
                                  .toString(),
                              color: Color.fromARGB(145, 146, 139, 246),
                            ),
                            DashboardWidget(
                              iconData: Icons.money,
                              title: "Service Area",
                              value: state.dashbordCount['service_area_count']
                                  .toString(),
                              color: Color.fromARGB(145, 146, 139, 246),
                            ),
                          ],
                        )
                      : const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DashboardWidget extends StatelessWidget {
  final IconData iconData;
  final String title, value;
  final Color color;
  const DashboardWidget({
    super.key,
    required this.iconData,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Material(
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    iconData,
                    size: 40,
                    color: const Color.fromARGB(255, 13, 2, 165),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: const Color.fromARGB(255, 13, 2, 165),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
