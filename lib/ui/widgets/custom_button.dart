import 'package:flutter/material.dart';
import 'package:prodel_admin/values/colors.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final bool isLoading;
  final String label;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.label,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        hoverColor: primaryColor.withOpacity(0.1),
        splashColor: primaryColor.withOpacity(0.1),
        onTap: isLoading ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Center(
            child: isLoading
                ? CircularProgressIndicator(
                    backgroundColor: primaryColor.withOpacity(0.1),
                    color: Colors.white,
                  )
                : Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}
