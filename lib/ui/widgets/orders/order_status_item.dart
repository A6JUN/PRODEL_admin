import 'package:flutter/material.dart';

enum OrderStatus { pending, packed, complete }

class OrderStatusItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final IconData iconData;
  final Function() onTap;
  final String? orderStatus;
  const OrderStatusItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.orderStatus,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: orderStatus == 'pending'
          ? Colors.yellow[800]!.withOpacity(0.2)
          : orderStatus == 'packed'
              ? Colors.blue[700]!.withOpacity(0.2)
              : orderStatus == 'complete'
                  ? Colors.green.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        hoverColor: orderStatus == 'pending'
            ? Colors.yellowAccent[100]
            : orderStatus == 'packed'
                ? Colors.blue[100]
                : orderStatus == 'complete'
                    ? Colors.green[100]
                    : Colors.grey[100],
        splashColor: orderStatus == 'pending'
            ? Colors.yellow[200]
            : orderStatus == 'packed'
                ? Colors.blue[200]
                : orderStatus == 'complete'
                    ? Colors.green[200]
                    : Colors.grey[200],
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                iconData,
                color: isSelected
                    ? orderStatus == 'pending'
                        ? Colors.yellow[800]
                        : orderStatus == 'packed'
                            ? Colors.blue[700]
                            : orderStatus == 'complete'
                                ? Colors.green
                                : Colors.grey[700]
                    : Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
