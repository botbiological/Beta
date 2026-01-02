import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provide/utils/routes/responsive.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late Timer _timer;
  Duration _remaining = const Duration(hours: 17, minutes: 35);

  final Duration initialDuration = const Duration(hours: 17, minutes: 35);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Reduce 1 second every tick
        _remaining -= const Duration(seconds: 1);

        // When timer reaches 0 → reset back to 17h 35m
        if (_remaining.inSeconds <= 0) {
          _remaining = initialDuration;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    final hours = _remaining.inHours;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(4),
        vertical: Responsive.h(1),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _timeColumn(hours.toString().padLeft(2, '0'), "HRS"),
          const Spacer(),
          _dividerText(),
          const Spacer(),
          _timeColumn(minutes.toString().padLeft(2, '0'), "MIN"),
          const Spacer(),
          _dividerText(),
          const Spacer(),
          _timeColumn(seconds.toString().padLeft(2, '0'), "SEC"),
        ],
      ),
    );
  }

  Widget _timeColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.textScaleFactor * 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.textScaleFactor * 10,
          ),
        ),
      ],
    );
  }

  Widget _dividerText() {
    return Text(
      ":",
      style: TextStyle(
        color: Colors.white,
        fontSize: Responsive.textScaleFactor * 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}










// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provide/utils/routes/responsive.dart';

// class ClockWidget extends StatefulWidget {
//   const ClockWidget({super.key});

//   @override
//   State<ClockWidget> createState() => _ClockWidgetState();
// }

// class _ClockWidgetState extends State<ClockWidget> {
//   late Timer _timer;

//   Duration _remaining = Duration.zero;

//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }

//   void _startTimer() {
//     _calculateRemainingTime();

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       _calculateRemainingTime();
//     });
//   }

//   void _calculateRemainingTime() {
//     final now = DateTime.now();

//     // Next reset time at 00:00 (midnight)
//     final tomorrow = DateTime(now.year, now.month, now.day + 1);

//     setState(() {
//       _remaining = tomorrow.difference(now);
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Responsive.init(context);

//     final days = _remaining.inDays;
//     final minutes = _remaining.inMinutes % 60;
//     final seconds = _remaining.inSeconds % 60;

//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: Responsive.w(4),
//         vertical: Responsive.h(1),
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.10),
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Row(
//         children: [
//           _timeColumn("$days", "DAYS"),
//           const Spacer(),
//           _dividerText(),
//           const Spacer(),
//           _timeColumn("$minutes", "MIN"),
//           const Spacer(),
//           _dividerText(),
//           const Spacer(),
//           _timeColumn("$seconds", "SEC"),
//         ],
//       ),
//     );
//   }

//   Widget _timeColumn(String value, String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: Responsive.textScaleFactor * 25,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: Responsive.textScaleFactor * 10,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _dividerText() {
//     return Text(
//       ":",
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: Responsive.textScaleFactor * 25,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }

