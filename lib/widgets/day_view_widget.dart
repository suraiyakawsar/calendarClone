import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import '../model/event.dart';
import '../pages/event_details_page.dart';

class DayViewWidget extends StatelessWidget {
  final GlobalKey<DayViewState>? state;
  final double? width;

  const DayViewWidget({
    Key? key,
    this.state,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DayView<Event>(
      key: state,
      width: width,
      // onEventTap: (event, date) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(event: event,))),
    );
  }
}
