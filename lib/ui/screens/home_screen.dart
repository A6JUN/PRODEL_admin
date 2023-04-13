import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prodel_admin/ui/screens/complaints_screen.dart';
import 'package:prodel_admin/ui/screens/customers_screen.dart';
import 'package:prodel_admin/ui/screens/dashboard_screen.dart';
import 'package:prodel_admin/ui/screens/delivery_screen.dart';
import 'package:prodel_admin/ui/screens/product_categories.dart';
import 'package:prodel_admin/ui/screens/product_screen.dart';
import 'package:prodel_admin/ui/screens/service_area_scree.dart';
import 'package:prodel_admin/ui/screens/shops_screen.dart';
import 'package:prodel_admin/ui/screens/suggestion_screen.dart';
import 'package:prodel_admin/ui/widgets/custom_alert_dialog.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(length: 9, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF9080F3)),
      ),
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: controller,
        children: const [
          DashboardScreen(),
          DeliveryScreen(),
          CustomerScreen(),
          ShopsScreen(),
          ProductsScreen(),
          ProductCategoriesScreen(),
          ServiceAreaScreen(),
          SuggestionScreen(),
          ComplaintsScreen(),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFE6E3F9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                'PRODEL',
                style: GoogleFonts.cambay(
                  textStyle:
                      Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DashboardItem(
                icon: Icons.dashboard_outlined,
                label: 'Dashboard',
                isSelected: controller!.index == 0,
                onTap: () {
                  controller!.animateTo(0);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DashboardItem(
                icon: Icons.local_shipping_outlined,
                label: 'Orders',
                isSelected: controller!.index == 1,
                onTap: () {
                  controller!.animateTo(1);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DashboardItem(
                icon: Icons.account_circle_outlined,
                label: 'Customers',
                isSelected: controller!.index == 2,
                onTap: () {
                  controller!.animateTo(2);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DashboardItem(
                icon: Icons.store_outlined,
                label: 'Shops',
                isSelected: controller!.index == 3,
                onTap: () {
                  controller!.animateTo(3);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DashboardItem(
                icon: Icons.shopping_bag_outlined,
                label: 'Products',
                isSelected: controller!.index == 4,
                onTap: () {
                  controller!.animateTo(4);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DashboardItem(
                icon: Icons.category_outlined,
                label: 'Product Categories',
                isSelected: controller!.index == 5,
                onTap: () {
                  controller!.animateTo(5);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DashboardItem(
                icon: Icons.place_outlined,
                label: 'Service Area',
                isSelected: controller!.index == 6,
                onTap: () {
                  controller!.animateTo(6);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DashboardItem(
                icon: Icons.comment_outlined,
                label: 'Suggestions',
                isSelected: controller!.index == 7,
                onTap: () {
                  controller!.animateTo(7);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DashboardItem(
                icon: Icons.warning_amber_outlined,
                label: 'Complaints',
                isSelected: controller!.index == 8,
                onTap: () {
                  controller!.animateTo(8);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DashboardItem(
                icon: Icons.exit_to_app_outlined,
                label: 'Logout',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => CustomAlertDialog(
                      title: 'Are you sure ?',
                      message: 'Are you sure that you want to logout ?',
                      primaryButtonLabel: 'Logout',
                      primaryOnPressed: () {},
                      secondaryButtonLabel: 'Cancel',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Function() onTap;
  const DashboardItem({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: isSelected ? const Color(0xFFB5B8FF) : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 30,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                label,
                style: GoogleFonts.cambay(
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
