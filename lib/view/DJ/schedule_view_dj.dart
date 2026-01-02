import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/widgets/text_widget.dart';

class ScheduleViewDj extends StatefulWidget {
  const ScheduleViewDj({super.key});

  @override
  State<ScheduleViewDj> createState() => _ScheduleViewDjState();
}

class _ScheduleViewDjState extends State<ScheduleViewDj> {
  DateTime selectedDate = DateTime.now();
  bool isAm = true;
  int selectedHour = 12;
  int selectedMinute = 0;

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Select Date',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                // Month header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      DateFormat('MMMM yyyy').format(selectedDate),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Weekday headers
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WeekdayText('S'),
                    WeekdayText('M'),
                    WeekdayText('T'),
                    WeekdayText('W'),
                    WeekdayText('T'),
                    WeekdayText('F'),
                    WeekdayText('S'),
                  ],
                ),
                const SizedBox(height: 16),
                // Calendar days
                CalendarGrid(
                  selectedDate: selectedDate,
                  onDateSelected: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
                const SizedBox(height: 32),
                TextWidget(text: 'Select Time'),
                const SizedBox(height: 16),
                // Time selector
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColor.darkGray,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TimeNumber(
                              value: selectedHour,
                              onChanged: (value) {
                                setState(() {
                                  selectedHour = value;
                                });
                              },
                              min: 1,
                              max: 12,
                            ),
                            const Text(
                              ' : ',
                              style: TextStyle(
                                color: AppColor.textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TimeNumber(
                              value: selectedMinute,
                              onChanged: (value) {
                                setState(() {
                                  selectedMinute = value;
                                });
                              },
                              min: 0,
                              max: 59,
                            ),
                            SizedBox(width: Responsive.w(2)),
                            Column(
                              children: [
                                AMPMButton(
                                  label: 'AM',
                                  isSelected: isAm,
                                  onTap: () {
                                    setState(() {
                                      isAm = true;
                                    });
                                  },
                                ),
                                const SizedBox(height: 8),
                                AMPMButton(
                                  label: 'PM',
                                  isSelected: !isAm,
                                  onTap: () {
                                    setState(() {
                                      isAm = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // AM/PM selector
                  ],
                ),
                const SizedBox(height: 32),
                // Save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle save action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeekdayText extends StatelessWidget {
  final String day;

  const WeekdayText(this.day, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      child: Text(
        day,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class CalendarGrid extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarGrid({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Get the first day of the month and the number of days in the month
    DateTime firstDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month,
      1,
    );
    int daysInMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    ).day;

    // Get the weekday of the first day (0 = Sunday, 6 = Saturday)
    int firstWeekday = firstDayOfMonth.weekday;

    // Generate the list of days to display (including leading/trailing days from adjacent months)
    List<DateTime> days = [];

    // Add leading days from previous month
    DateTime previousMonth = DateTime(
      selectedDate.year,
      selectedDate.month - 1,
      1,
    );
    int daysInPreviousMonth = DateTime(
      selectedDate.year,
      selectedDate.month,
      0,
    ).day;
    for (
      int i = daysInPreviousMonth - firstWeekday + 1;
      i <= daysInPreviousMonth;
      i++
    ) {
      days.add(DateTime(previousMonth.year, previousMonth.month, i));
    }

    // Add current month days
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(selectedDate.year, selectedDate.month, i));
    }

    // Add trailing days from next month to complete the grid
    int remaining = 42 - days.length; // 6 rows x 7 columns = 42 cells
    DateTime nextMonth = DateTime(selectedDate.year, selectedDate.month + 1, 1);
    for (int i = 1; i <= remaining; i++) {
      days.add(DateTime(nextMonth.year, nextMonth.month, i));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        DateTime day = days[index];
        bool isCurrentMonth = day.month == selectedDate.month;
        bool isSelected =
            day.day == selectedDate.day &&
            day.month == selectedDate.month &&
            day.year == selectedDate.year;

        return GestureDetector(
          onTap: () => onDateSelected(day),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.red : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isCurrentMonth
                      ? (isSelected ? Colors.white : Colors.white)
                      : Colors.grey[400],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TimeNumber extends StatelessWidget {
  final int value;
  final Function(int) onChanged;
  final int min;
  final int max;

  const TimeNumber({
    super.key,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColor.whiteColor.withValues(alpha: 0.10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            IconButton(
              icon: Icon(
                color: AppColor.textColor,
                Icons.arrow_drop_up,
                size: Responsive.textScaleFactor * 24,
              ),
              onPressed: () {
                int newValue = value + 1;
                if (newValue > max) newValue = min;
                onChanged(newValue);
              },
            ),
            SizedBox(
              width: 50,
              child: Text(
                value.toString().padLeft(2, '0'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: Responsive.textScaleFactor * 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColor.textColor,
                size: Responsive.textScaleFactor * 24,
              ),
              onPressed: () {
                int newValue = value - 1;
                if (newValue < min) newValue = max;
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AMPMButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const AMPMButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.seconadryColor : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}