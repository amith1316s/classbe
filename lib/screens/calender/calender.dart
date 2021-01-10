import 'package:classbe/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  static String routeName = "/calender";
  Calender({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Class A0',
        'Class B0',
        'Class C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Class A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Class A2',
        'Class B2',
        'Class C2',
        'Class D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Class A3', 'Class B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Class A4',
        'Class B4',
        'Class C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Class A5',
        'Class B5',
        'Class C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Class A6', 'Class B6'],
      _selectedDay: ['Class A7', 'Class B7', 'Class C7', 'Class D7'],
      _selectedDay.add(Duration(days: 1)): [
        'Class A8',
        'Class B8',
        'Class C8',
        'Class D8'
      ],
      _selectedDay.add(Duration(days: 3)):
          Set.from(['Class A9', 'Class A9', 'Class B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Class A10',
        'Class B10',
        'Class C10'
      ],
      _selectedDay.add(Duration(days: 11)): ['Class A11', 'Class B11'],
      _selectedDay.add(Duration(days: 17)): [
        'Class A12',
        'Class B12',
        'Class C12',
        'Class D12'
      ],
      _selectedDay.add(Duration(days: 22)): ['Class A13', 'Class B13'],
      _selectedDay.add(Duration(days: 26)): [
        'Class A14',
        'Class B14',
        'Class C14'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calender"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      // initialCalendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: kMainPrimaryColor,
        todayColor: kMainPrimaryColor,
        markersColor: kMainPrimaryColor,
        weekdayStyle: TextStyle(color: Colors.black),
        weekendStyle: TextStyle(color: Colors.grey),
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: kMainPrimaryColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
