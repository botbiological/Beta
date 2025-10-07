import 'package:flutter/material.dart';
import 'package:provide/utils/routes/responsive.dart';

class CustomRoleOptionTileCard extends StatefulWidget {
  final String roleName;
  final bool isSelected;
  final VoidCallback onTap;
  final Color primaryColor;
  final Color textColor;
  final Color bgColor;

  const CustomRoleOptionTileCard({
    super.key,
    required this.roleName,
    required this.isSelected,
    required this.onTap,
    required this.primaryColor,
    required this.textColor,
    required this.bgColor,
  });

  @override
  State<CustomRoleOptionTileCard> createState() =>
      _CustomRoleOptionTileCardState();
}

class _CustomRoleOptionTileCardState extends State<CustomRoleOptionTileCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: Responsive.h(8),
          padding: EdgeInsets.symmetric(horizontal: Responsive.w(20)),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.red : Colors.grey[800],
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovered
                  ? Colors.white
                  : (widget.isSelected
                        ? widget.primaryColor
                        : Colors.transparent),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.roleName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.sp(12),
                  color: widget.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
