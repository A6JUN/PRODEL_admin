import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prodel_admin/ui/screen/customers_screen.dart';
import 'package:prodel_admin/ui/screen/dashboard_screen.dart';
import 'package:prodel_admin/ui/screen/delivery_screen.dart';
import 'package:prodel_admin/ui/screen/login_screen.dart';
import 'package:prodel_admin/ui/screen/product_screen.dart';
import 'package:prodel_admin/ui/screen/analytics_screen.dart';
import 'package:prodel_admin/ui/screen/shops_screen.dart';
import 'package:prodel_admin/ui/screen/message_screen.dart';
import 'package:prodel_admin/ui/screen/settings_screen.dart';

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
    controller = TabController(length: 8, vsync: this);
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
          CustomerScreen(),
          DeliveryScreen(),
          ShopsScreen(),
          Analytics_screen(),
          ProductsScreen(),
          MessageScreen(),
          Settings(),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFE6E3F9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'PRODEL',
                style: GoogleFonts.cambay(
                  textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: DashboardItem(
                icon: Icons.dashboard,
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
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: DashboardItem(
                icon: Icons.account_circle,
                label: 'Customers',
                isSelected: controller!.index == 1,
                onTap: () {
                  controller!.animateTo(1);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: DashboardItem(
                icon: Icons.local_shipping,
                label: 'Delivery &preorder',
                isSelected: controller!.index == 2,
                onTap: () {
                  controller!.animateTo(2);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: DashboardItem(
                icon: Icons.store,
                label: 'shops',
                isSelected: controller!.index == 3,
                onTap: () {
                  controller!.animateTo(3);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: DashboardItem(
                icon: Icons.auto_graph,
                label: 'Analytics',
                isSelected: controller!.index == 4,
                onTap: () {
                  controller!.animateTo(4);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: DashboardItem(
                icon: Icons.inventory,
                label: 'Products',
                isSelected: controller!.index == 5,
                onTap: () {
                  controller!.animateTo(5);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: DashboardItem(
                icon: Icons.mail,
                label: 'Messages',
                isSelected: controller!.index == 6,
                onTap: () {
                  controller!.animateTo(6);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: DashboardItem(
                icon: Icons.logout,
                label: 'Logout',
                isSelected: controller!.index == 7,
                onTap: () {
                  controller!.animateTo(7);
                  setState(
                    () {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Column(
                                  children: const [],
                                ),
                                content: const Text(
                                  "Are you sure you want to Logout? ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                      );
                                    },
                                    child: Container(
                                      color: Colors.blue,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text(
                                        "Logout",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                    },
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
    return InkWell(
      onTap: onTap,
      child: Material(
        color: isSelected ? const Color(0xFFB5B8FF) : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   width: 10,
              //   height: 10,
              //   color: const Color(0xFF5B62FC),
              // ),
              Icon(
                icon,
                color: Colors.black,
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                label,
                style: GoogleFonts.cambay(
                  textStyle:
                      Theme.of(context).textTheme.headlineSmall!.copyWith(
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
