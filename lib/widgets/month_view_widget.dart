import 'package:calendar/pages/event_details_page.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import '../model/event.dart';

class MonthViewWidget extends StatelessWidget {
  final GlobalKey<MonthViewState>? state;
  final double? width;

  const MonthViewWidget({
    Key? key,
    this.state,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MonthView<Event>(
      key: state,
      width: width,
      onEventTap: (event, date) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(event: event))),
    );
  }
}
