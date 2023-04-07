import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';


class MonthlySummaryHeatMap extends StatelessWidget {

  final Map<DateTime, int>? heatmapDatasets;
  final int count;

   MonthlySummaryHeatMap({
    super.key,
     required this.heatmapDatasets,
     required this.count,
  });



  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: HeatMap(
        startDate: DateTime.now().subtract(const Duration(days: 60)),
        endDate: DateTime.now().add(const Duration(days: 20)),
         datasets:heatmapDatasets ,
        defaultColor: Colors.grey[300],
        textColor: Colors.black,
        showColorTip: true,
        showText: false,
        scrollable: true,
        size: 25,
        colorsets: const {
          1: Colors.redAccent,
        },
        onClick: (count) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('コミット数は$countです')));
        },
      ),
    );
  }
}


