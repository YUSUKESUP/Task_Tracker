import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MonthlySummaryHeatMap extends StatelessWidget {
  final Map<DateTime, int>? heatmapDatasets;
  final int value;

  MonthlySummaryHeatMap({
    super.key,
    required this.heatmapDatasets,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    ///ヒートマップ
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: HeatMap(
        startDate: DateTime.now().subtract(const Duration(days: 55)),
        endDate: DateTime.now().add(const Duration(days: 10)),
        datasets: heatmapDatasets,
        defaultColor: Colors.white38,
        textColor: Colors.black,
        showColorTip: true,
        showText: false,
        scrollable: true,
        size: 25,
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
