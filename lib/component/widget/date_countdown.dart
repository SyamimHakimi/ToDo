import 'dart:async';

import 'package:duration/duration.dart';
import 'package:flutter/material.dart';

class DateCountdown extends StatefulWidget {
  const DateCountdown({
    required this.completed,
    required this.dateStart,
    required this.dateEnd,
    required this.textStyle,
    Key? key,
  })  : super(key: key);

  final bool? completed;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final TextStyle textStyle;

  @override
  State<DateCountdown> createState() => _DateCountdownState();
}

class _DateCountdownState extends State<DateCountdown> {
  late Timer _timer;
  String? _countdown;

  @override
  void initState() {
    /// Start the countdown
    _timer = Timer.periodic(const Duration(seconds: 1),
      (Timer timer) => setState(runCountdown)
    );
    runCountdown();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void runCountdown() {
    /// Skip if task completed
    if (widget.completed != null && widget.completed!) {
      _countdown = "-";

    /// Do not count if task not started
    } else if (widget.dateStart != null && widget.dateStart!.isBefore(DateTime.now())) {

      Duration? duration = widget.dateEnd?.difference(DateTime.now());
      if (duration != null && !duration.isNegative) {
        _countdown = prettyDuration(duration, upperTersity: DurationTersity.day,
            abbreviated: true, delimiter: " ", spacer: "");
      } else {
        _countdown = "Expired";
      }

    /// Incomplete and not started task
    } else {
      _countdown = "Task Not Started";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Text("$_countdown", style: widget.textStyle);
  }
}
