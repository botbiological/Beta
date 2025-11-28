import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final bool loading;
  final VoidCallback? onPress; // Made nullable
  final Widget? prefix; // optional prefix (icon, svg, etc.)

  final String? suffixIcon;

  const AuthButton({
    super.key,
    required this.buttonText,
    required this.loading,
    this.onPress, // No longer required since it's nullable
    this.prefix,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    bool isEnabled = !loading && onPress != null;
    
    return GestureDetector(
      onTap: isEnabled ? onPress : null,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isEnabled 
              ? AppColor.seconadryColor 
              : AppColor.seconadryColor.withValues(alpha: 0.5),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Center(
          child: loading
              ? const CustomLoadingAnimation()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefix != null) prefix!, // show prefix
                    if (prefix != null) const SizedBox(width: 5), // spacing
                    Text(
                      buttonText,
                      style: TextStyle(
                        color: isEnabled 
                            ? AppColor.textColor 
                            : AppColor.textColor.withValues(alpha: 0.6),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (suffixIcon != null) ...[
                      SizedBox(width: Responsive.w(2)),
                      SvgPicture.asset(
                        suffixIcon ?? '',
                        colorFilter: ColorFilter.mode(
                          isEnabled 
                              ? AppColor.textColor 
                              : AppColor.textColor.withValues(alpha: 0.6),
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: Colors.white,
      size: MediaQuery.sizeOf(context).height * 0.02,
    );
  }
}
