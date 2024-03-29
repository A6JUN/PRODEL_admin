import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Widget child;
  final Color? color;
  final double borderRadius;
  final Function()? onPressed;

  const CustomCard({
    super.key,
    required this.child,
    this.onPressed,
    this.color = Colors.white,
    this.borderRadius = 20,
  });

  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovering = true),
        onExit: (event) => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: widget.color,
            boxShadow: _isHovering
                ? []
                : [
                    const BoxShadow(
                      color: Colors.black26,
                      offset: Offset(1, 1),
                      blurRadius: 3,
                    )
                  ],
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
