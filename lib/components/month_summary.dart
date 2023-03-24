import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';


import '../datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      // child: HeatMapCalendar(
      //   defaultColor: Colors.white,
      //   flexible: true,
      //   colorMode: ColorMode.color,
      //   datasets: {
      //     DateTime(2023, 1, 6): 3,
      //     DateTime(2023, 1, 7): 7,
      //     DateTime(2023, 1, 8): 10,
      //     DateTime(2023, 1, 9): 13,
      //     DateTime(2023, 1, 13): 6,
      //   },
      //   colorsets: const {
      //     1: Colors.red,
      //     3: Colors.orange,
      //     5: Colors.yellow,
      //     7: Colors.green,
      //     9: Colors.blue,
      //     11: Colors.indigo,
      //     13: Colors.purple,
      //   },
      //   onClick: (value) {
      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
      //   },
      // ),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 60)),
        datasets: datasets,
        colorMode: ColorMode.opacity,
        defaultColor: Colors.grey[200],
        textColor: Colors.black,
        showColorTip: true,
        showText: true,
        scrollable: true,
        size: 25,
        colorsets: const {
          1: Color.fromARGB(20, 2, 179, 8),
          2: Color.fromARGB(40, 2, 179, 8),
          3: Color.fromARGB(60, 2, 179, 8),
          4: Color.fromARGB(80, 2, 179, 8),
          5: Color.fromARGB(100, 2, 179, 8),
          6: Color.fromARGB(120, 2, 179, 8),
          7: Color.fromARGB(150, 2, 179, 8),
          8: Color.fromARGB(180, 2, 179, 8),
          9: Color.fromARGB(220, 2, 179, 8),
          10: Color.fromARGB(255, 2, 179, 8),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}