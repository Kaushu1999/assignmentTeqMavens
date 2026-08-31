import 'package:assignment/core/constants/app_colors.dart';
import 'package:assignment/core/constants/app_text_styles.dart';
import 'package:assignment/core/widgets/app_background.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingHotelScreen extends StatefulWidget {
  const BookingHotelScreen({super.key});

  @override
  State<BookingHotelScreen> createState() => _BookingHotelScreenState();
}

class _BookingHotelScreenState extends State<BookingHotelScreen> {
  static final BookingStay _stay = BookingStay(
    title: '2-night stay',
    dateRange: 'Mon, Oct 24 - Wed, Oct 26',
    initialMonth: DateTime(2026, 2),
  );

  late DateTime _focusedDay = _stay.initialMonth;

  void _goToPreviousMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            _BookingHeader(stay: _stay),
            const SizedBox(height: 70),
            _CalendarCard(
              focusedDay: _focusedDay,
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
            ),
            const SizedBox(height: 40),
            _CalendarControls(
              onPrevious: _goToPreviousMonth,
              onNext: _goToNextMonth,
            ),
          ],
        ),
      ),
    );
  }
}

class BookingStay {
  const BookingStay({
    required this.title,
    required this.dateRange,
    required this.initialMonth,
  });

  final String title;
  final String dateRange;
  final DateTime initialMonth;
}

class _BookingHeader extends StatelessWidget {
  const _BookingHeader({required this.stay});

  final BookingStay stay;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stay.title,
                style: AppTextStyles.heading1.copyWith(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                stay.dateRange,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            minimumSize: const Size(0, 36),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Cancel Date',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.notificationBadge,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.notificationBadge,
              decorationThickness: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _CalendarCard extends StatelessWidget {
  const _CalendarCard({required this.focusedDay, required this.onPageChanged});

  final DateTime focusedDay;
  final ValueChanged<DateTime> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(26, 14, 26, 28),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: TableCalendar<void>(
        firstDay: DateTime(2025),
        lastDay: DateTime(2027, 12, 31),
        focusedDay: focusedDay,
        calendarFormat: CalendarFormat.month,
        availableCalendarFormats: const {CalendarFormat.month: 'Month'},
        availableGestures: AvailableGestures.horizontalSwipe,
        daysOfWeekVisible: false,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          leftChevronVisible: false,
          rightChevronVisible: false,
          titleCentered: true,
          headerPadding: const EdgeInsets.only(bottom: 24),
          titleTextStyle: AppTextStyles.heading3,
        ),
        calendarStyle: CalendarStyle(
          cellMargin: EdgeInsets.zero,
          cellPadding: EdgeInsets.zero,
          outsideDaysVisible: true,
          defaultTextStyle: AppTextStyles.bodyMedium.copyWith(
            color: const Color(0xFFD8D8D8),
            fontSize: 15,
          ),
          weekendTextStyle: AppTextStyles.bodyMedium.copyWith(
            color: const Color(0xFFD8D8D8),
            fontSize: 15,
          ),
          outsideTextStyle: AppTextStyles.bodyMedium.copyWith(
            color: const Color(0xFFD8D8D8),
            fontSize: 15,
          ),
          todayDecoration: const BoxDecoration(shape: BoxShape.circle),
          todayTextStyle: AppTextStyles.bodyMedium.copyWith(
            color: const Color(0xFFD8D8D8),
            fontSize: 15,
          ),
        ),
        rowHeight: 52,
        onPageChanged: onPageChanged,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return _CalendarDayLabel(day: day);
          },
          todayBuilder: (context, day, focusedDay) {
            return _CalendarDayLabel(day: day);
          },
          outsideBuilder: (context, day, focusedDay) {
            return _CalendarDayLabel(day: day);
          },
          disabledBuilder: (context, day, focusedDay) {
            return _CalendarDayLabel(
              day: day,
              color: const Color(0xFFD8D8D8).withValues(alpha: 0.45),
            );
          },
        ),
      ),
    );
  }
}

class _CalendarDayLabel extends StatelessWidget {
  const _CalendarDayLabel({
    required this.day,
    this.color = const Color(0xFFD8D8D8),
  });

  final DateTime day;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${day.day}',
        style: AppTextStyles.bodyMedium.copyWith(color: color, fontSize: 15),
      ),
    );
  }
}

class _CalendarControls extends StatelessWidget {
  const _CalendarControls({required this.onPrevious, required this.onNext});

  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CalendarControlButton(
          icon: Icons.chevron_left_rounded,
          onTap: onPrevious,
        ),
        const SizedBox(width: 62),
        _CalendarControlButton(
          icon: Icons.chevron_right_rounded,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _CalendarControlButton extends StatelessWidget {
  const _CalendarControlButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Material(
        color: AppColors.primary,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
