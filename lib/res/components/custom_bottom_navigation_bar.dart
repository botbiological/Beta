import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Function(int)? onTap;
  final int selectedIndex;
  final String role; // Pass the role to determine icon flow

  const CustomBottomNavBar({
    Key? key,
    this.onTap,
    this.selectedIndex = 0,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Icon sets for different roles
    final userFlowPath = [
      'assets/icons/home.svg',
      'assets/icons/boxing-glove.svg',
      'assets/icons/add.svg',
      'assets/icons/folder-library.svg',
      'assets/icons/message.svg',
    ];

    final artistFlowPath = [
      'assets/icons/home.svg',
      'assets/icons/tracks.svg',
      'assets/icons/analytics.svg',
      'assets/icons/champion.svg',
      'assets/icons/message.svg',
    ];

    final producerFlowPath = [
      'assets/icons/home.svg',
      'assets/icons/tracks.svg',
      'assets/icons/analytics.svg',
      'assets/icons/champion.svg',
      'assets/icons/message.svg',
    ];

    final djFlowPath = [
      'assets/icons/home.svg',
      'assets/icons/tracks.svg',
      'assets/icons/analytics.svg',
      'assets/icons/champion.svg',
      'assets/icons/message.svg',
    ];

    // Choose icon list based on role
    List<String> iconPath;
    switch (role.toLowerCase()) {
      case 'user':
        iconPath = userFlowPath;
        break;
      case 'artist':
        iconPath = artistFlowPath;
        break;
      case 'producer':
        iconPath = producerFlowPath;
      default:
        iconPath = djFlowPath;
    }

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 238, 238).withOpacity(0.2),
        borderRadius: BorderRadius.circular(45),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(iconPath.length, (index) {
          // Center "add" button
          if (index == 2) {
            return GestureDetector(
              onTap: () => onTap?.call(index),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == selectedIndex
                      ? Colors.red
                      : Colors.grey[800], // Always grey
                ),
                child: SvgPicture.asset(iconPath[index], color: Colors.white),
              ),
            );
          }

          // Other buttons
          return GestureDetector(
            onTap: () => onTap?.call(index),
            child: index == selectedIndex
                ? Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red, // Red highlight
                    ),
                    child: SvgPicture.asset(
                      iconPath[index],
                      color: Colors.white,
                    ),
                  )
                : SvgPicture.asset(iconPath[index], color: Colors.white),
          );
        }),
      ),
    );
  }
}
