import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';


class MonthlySummary extends StatelessWidget {

  final Map<DateTime, int>? heatmapDatasets;

   MonthlySummary({
    super.key,
     required this.heatmapDatasets,
  });



  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      // child: HeatMapCalendar(
      //   weekTextColor: Colors.black,
      //   textColor: Colors.black,
      //   showColorTip: true,
      //   colorMode: ColorMode.opacity,
      //   datasets: {
      //     DateTime(2023, 1, 6): 1,
      //     DateTime(2023, 1, 7): 2,
      //     DateTime(2023, 1, 8): 3,
      //     DateTime(2023, 1, 9): 4,
      //     DateTime(2023, 1, 9): 5,
      //   },
      //   colorsets: const {
      //     1: Colors.redAccent,
      //     2: Color.fromARGB(150, 2, 179, 8),
      //     3: Color.fromARGB(180, 2, 179, 8),
      //     4: Color.fromARGB(220, 2, 179, 8),
      //     50: Color.fromARGB(255, 2, 179, 8),
      //   },
      // ),
      child: HeatMap(
        startDate: DateTime.now().subtract(const Duration(days: 60)),
        endDate: DateTime.now().add(const Duration(days: 20)),
         datasets:heatmapDatasets ,


        colorMode: ColorMode.opacity,
        defaultColor: Colors.white,
        textColor: Colors.black,
        showColorTip: true,
        showText: false,
        scrollable: true,
        size: 25,
        colorsets: const {
          1: Colors.redAccent,
        }
        // onClick: (value) {
        //   ScaffoldMessenger.of(context)
        //       .showSnackBar(SnackBar(content: Text(value.toString())));
        // },
      ),
    );
  }
}


