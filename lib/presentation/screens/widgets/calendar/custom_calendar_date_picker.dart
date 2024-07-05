import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/screens/widgets/calendar/calendar_chevron_button.dart';
import 'package:make_appointment_app/presentation/screens/widgets/calendar/calendar_day_card.dart';

class CustomCalendarDatePicker extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;
  final List<DateTime> availableDates;
  final List<DateTime> notAvailableDates;

  const CustomCalendarDatePicker({
    super.key,
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
    required this.onDateChanged,
    this.availableDates = const [],
    this.notAvailableDates = const [],
  });

  @override
  State<CustomCalendarDatePicker> createState() =>
      _CustomCalendarDatePickerState();
}

class _CustomCalendarDatePickerState extends State<CustomCalendarDatePicker> {
  late DateTime _currentSelectedDate;
  late PageController _pageController;
  int _currentMonth = 0;
  int _currentYear = 0;
  int _currentPage = 0;
  int _weeksInMonth = 6;
  double _dayItemHeight = 0;
  final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  DateTime get _firstDate => widget.firstDate;
  DateTime get _lastDate => widget.lastDate;
  DateTime get _initialDate => widget.initialDate;
  List<DateTime> get _availableDates => widget.availableDates;
  List<DateTime> get _notAvailableDates => widget.notAvailableDates;

  @override
  void initState() {
    super.initState();
    _currentSelectedDate =
        DateTime(_initialDate.year, _initialDate.month, _initialDate.day);
    _currentMonth = _initialDate.month;
    _currentYear = _initialDate.year;
    _currentPage = _initialCurrentPage();
    _pageController = PageController(
      initialPage: _currentPage,
    );
    _calculateWeeksInMonth();
  }

  int _initialCurrentPage() {
    return (_currentYear - _firstDate.year) * 12 +
        _initialDate.month -
        _firstDate.month;
  }

  int get _pageCount {
    final yearDif = _lastDate.year - _firstDate.year;
    final monthDif = _lastDate.month - _firstDate.month + 1;
    return yearDif * 12 + monthDif;
  }

  bool _hasNext() {
    DateTime nextMonthFirstDay = DateTime(_currentYear, _currentMonth + 1, 1);
    return nextMonthFirstDay.isBefore(_lastDate) ||
        nextMonthFirstDay.isAtSameMomentAs(_lastDate);
  }

  bool _hasPrevious() {
    return _currentPage > 0;
  }

  DateStatus _getStatusForDate(DateTime date) {
    if (date.difference(_firstDate).inDays < 0 ||
        date.difference(_lastDate).inDays > 0) {
      return DateStatus.notAvailable;
    }
    if (_availableDates.contains(date)) return DateStatus.available;
    if (_notAvailableDates.contains(date)) return DateStatus.notAvailable;
    return DateStatus.available;
  }

  void _handlePageChanged(int index) {
    setState(() {
      int nextMonth = _firstDate.month + index;
      _currentMonth = (nextMonth - 1) % 12 + 1;
      _currentYear = _firstDate.year + ((nextMonth - 1) ~/ 12);
      _currentPage = index;
      _calculateWeeksInMonth();
    });
  }

  void _calculateWeeksInMonth() {
    int firstWeekDay = DateTime(_currentYear, _currentMonth, 1).weekday;
    int daysInMonth = DateTime(_currentYear, _currentMonth + 1, 0).day;
    _weeksInMonth = ((daysInMonth + firstWeekDay - 1) / 7).ceil();
  }

  bool _isDayItemDisable(DateStatus dateStatus) {
    return dateStatus == DateStatus.notAvailable;
  }

  void _onDaySelected(DateTime date) {
    setState(() {
      _currentSelectedDate = date;
      widget.onDateChanged(date);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _dayItemHeight = constraints.maxWidth / 7;
        return Column(
          children: [
            _buildHeader(),
            _buildWeekDays(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceInOut,
              height: _dayItemHeight * _weeksInMonth,
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: _handlePageChanged,
                itemCount: _pageCount,
                itemBuilder: (_, __) {
                  return _buildCalendar();
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CalendarChevronButton(
            icon: Icons.arrow_back_ios_sharp,
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            isDisable: !_hasPrevious(),
          ),
          const SizedBox(width: 24),
          Text(
            "${_currentMonth.toString().padLeft(2, '0')} - $_currentYear",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 24),
          CalendarChevronButton(
            icon: Icons.arrow_forward_ios_sharp,
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            isDisable: !_hasNext(),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    return Row(
      children: [
        ...weekDays.map(
          (week) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                week,
                style: AppTextStyle.labelMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    List<Widget> dayWidgets = [];
    DateTime firstDayOfMonth = DateTime(_currentYear, _currentMonth, 1);
    int daysInMonth = DateTime(_currentYear, _currentMonth + 1, 0).day;

    for (int i = 1; i < firstDayOfMonth.weekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(_currentYear, _currentMonth, day);
      DateStatus dateStatus = _getStatusForDate(date);
      dayWidgets.add(
        CalendarDayCard(
          date: date,
          dateStatus: dateStatus,
          isSelected: _currentSelectedDate.isAtSameMomentAs(date),
          onTap:
              _isDayItemDisable(dateStatus) ? null : () => _onDaySelected(date),
        ),
      );
    }

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      shrinkWrap: true,
      children: dayWidgets,
    );
  }
}
