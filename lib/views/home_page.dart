import 'package:calendar/extension.dart';
import 'package:calendar/widgets/month_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import '../pages/create_event_page.dart';
import '../model/event.dart';
import '../widgets/day_view_widget.dart';
import '../widgets/week_view_widget.dart';

DateTime get _now => DateTime.now();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //initialize variables here ...
  int _selectedIndex = 0;
  String _value = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(),
        // body: buildBody(_value),
        body: CalendarControllerProvider<Event>(
          controller: EventController<Event>()..addAll(_events),
          child: buildBody(_value),
        ),
        bottomNavigationBar: buildBotBar(),
      );

  AppBar buildAppBar() => AppBar(
        title: const Text('Schedule'),
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.all(9.0),
          child: CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: Text(
              "VC",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actions: [
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _value = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "Day",
                child: Text("Day"),
              ),
              const PopupMenuItem(
                value: "Week",
                child: Text("Week"),
              ),
              const PopupMenuItem(
                value: "Month",
                child: Text("Month"),
              ),
            ],
          ),
        ],
      );

  Widget buildBody(value) {
    if (value == "Day") {
      return Scaffold(
        body: const DayViewWidget(),
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          onPressed: _addEvent,
          child: const Icon(Icons.add),
        ),
      );
    } else if (value == "Week") {
      return Scaffold(
        body: const WeekViewWidget(),
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          onPressed: _addEvent,
          child: const Icon(Icons.add),
        ),
      );
    } else if (value == "Month") {
      return Scaffold(
        body: const MonthViewWidget(),
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          onPressed: _addEvent,
          child: const Icon(Icons.add),
        ),
      );
    }

    return Scaffold(
      body: const MonthViewWidget(),
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        onPressed: _addEvent,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addEvent() async {
    final event = await context.pushRoute<CalendarEventData<Event>>(
      const CreateEventPage(
        withDuration: true,
      ),
    );
    if (event == null) return;
    CalendarControllerProvider.of<Event>(context).controller.add(event);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildBotBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_copy),
          label: 'Docs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: 'Assessment',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}

List<CalendarEventData<Event>> _events = [
  CalendarEventData(
    date: _now,
    event: const Event("Joe's Birthday"),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
  CalendarEventData(
    date: _now.add(const Duration(days: 1)),
    startTime: DateTime(_now.year, _now.month, _now.day, 18),
    endTime: DateTime(_now.year, _now.month, _now.day, 19),
    event: const Event("Wedding anniversary"),
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData(
    date: _now,
    startTime: DateTime(_now.year, _now.month, _now.day, 14),
    endTime: DateTime(_now.year, _now.month, _now.day, 17),
    event: const Event("Football Tournament"),
    title: "Football Tournament",
    description: "Go to football tournament.",
  ),
  CalendarEventData(
    date: _now.add(const Duration(days: 3)),
    startTime: DateTime(_now.add(const Duration(days: 3)).year, _now.add(const Duration(days: 3)).month, _now.add(const Duration(days: 3)).day, 10),
    endTime: DateTime(_now.add(const Duration(days: 3)).year, _now.add(const Duration(days: 3)).month, _now.add(const Duration(days: 3)).day, 14),
    event: const Event("Sprint Meeting."),
    title: "Sprint Meeting.",
    description: "Last day of project submission for last year.",
  ),
  CalendarEventData(
    date: _now.subtract(const Duration(days: 2)),
    startTime: DateTime(_now.subtract(const Duration(days: 2)).year, _now.subtract(const Duration(days: 2)).month, _now.subtract(const Duration(days: 2)).day, 14),
    endTime: DateTime(_now.subtract(const Duration(days: 2)).year, _now.subtract(const Duration(days: 2)).month, _now.subtract(const Duration(days: 2)).day, 16),
    event: const Event("Team Meeting"),
    title: "Team Meeting",
    description: "Team Meeting",
  ),
  CalendarEventData(
    date: _now.subtract(const Duration(days: 2)),
    startTime: DateTime(_now.subtract(const Duration(days: 2)).year, _now.subtract(const Duration(days: 2)).month, _now.subtract(const Duration(days: 2)).day, 10),
    endTime: DateTime(_now.subtract(const Duration(days: 2)).year, _now.subtract(const Duration(days: 2)).month, _now.subtract(const Duration(days: 2)).day, 12),
    event: const Event("Chemistry Viva"),
    title: "Chemistry Viva",
    description: "Today is Joe's birthday.",
  ),
];
