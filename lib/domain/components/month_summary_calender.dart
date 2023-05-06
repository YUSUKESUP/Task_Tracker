import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MonthlySummaryCalemder extends StatelessWidget {
  final Map<DateTime, int>? heatmapDatasets;
  final int value;

  MonthlySummaryCalemder({
    super.key,
    required this.heatmapDatasets,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    ///ヒーマップカレンダー
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: HeatMapCalendar(
        weekTextColor: Colors.black,
        textColor: Colors.black,
        showColorTip: true,
        colorMode: ColorMode.opacity,
        datasets: heatmapDatasets,
        colorsets: const {
          1: Colors.redAccent,
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
