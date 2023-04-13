import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
              children: [
                Text(
                  "Dashboard",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
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
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: const [
                DashboardWidget(
                  iconData: Icons.auto_graph,
                  title: "Total Sales",
                  value: '20000',
                  color: Color.fromARGB(145, 146, 139, 246),
                ),
                DashboardWidget(
                  iconData: Icons.bar_chart,
                  title: "Total Expenses",
                  value: '20000',
                  color: Color.fromARGB(145, 146, 139, 246),
                ),
                DashboardWidget(
                  iconData: Icons.money,
                  title: "Total income",
                  value: '20000',
                  color: Color.fromARGB(145, 146, 139, 246),
                ),
              ],
            ),
          ],
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
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(
                    iconData,
                    size: 40,
                    color: const Color.fromARGB(255, 13, 2, 165),
                  ),
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
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Last 24 Hours')
            ],
          ),
        ),
      ),
    );
  }
}
