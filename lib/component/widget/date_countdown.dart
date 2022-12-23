import 'dart:async';

import 'package:duration/duration.dart';
import 'package:flutter/material.dart';

class DateCountdown extends StatefulWidget {
  const DateCountdown({
    required this.dateEnd,
    required this.textStyle,
    Key? key,
  })  : super(key: key);

  final DateTime? dateEnd;
  final TextStyle textStyle;

  @override
  State<DateCountdown> createState() => _DateCountdownState();
}

class _DateCountdownState extends State<DateCountdown> {
  late Timer _timer;
  Duration? _duration;

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
    _duration = widget.dateEnd?.difference(DateTime.now());
    if (_duration != null && _duration!.isNegative) {
      _timer.cancel();
    }
  }


  @override
  Widget build(BuildContext context) {
    String countdown = "-";
    if (_duration != null && !_duration!.isNegative) {
      countdown = prettyDuration(_duration!, upperTersity: DurationTersity.day,
        abbreviated: true, delimiter: " ", spacer: "");
    }
    return Text(countdown, style: widget.textStyle);
  }
}
