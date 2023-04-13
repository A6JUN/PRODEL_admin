import 'package:flutter/material.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
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
          ],
        ),
      ),
    );
  }
}
