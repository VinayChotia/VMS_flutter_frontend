// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:modernlogintute/components/legend_item.dart';

// class DashboardPie extends StatefulWidget {
//   const DashboardPie({super.key});

//   @override
//   State<DashboardPie> createState() => _DashboardPieState();
// }

// class _DashboardPieState extends State<DashboardPie> {
//   int touchedIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // 🔥 PIE CHART (COMPACT + ANIMATED)
//         SizedBox(
//           height: 300,
//           child: PieChart(
//             PieChartData(
//               sectionsSpace: 2,
//               centerSpaceRadius: 35,

//               // 👉 TOUCH INTERACTION
//               pieTouchData: PieTouchData(
//                 touchCallback: (event, response) {
//                   setState(() {
//                     if (!event.isInterestedForInteractions ||
//                         response == null ||
//                         response.touchedSection == null) {
//                       touchedIndex = -1;
//                       return;
//                     }
//                     touchedIndex = response.touchedSection!.touchedSectionIndex;
//                   });
//                 },
//               ),

//               sections: showingSections(),
//             ),

//             // 👉 SMOOTH ANIMATION
//             swapAnimationDuration: const Duration(milliseconds: 500),
//             swapAnimationCurve: Curves.easeInOut,
//           ),
//         ),

//         const SizedBox(height: 12),

//         // 🔥 LEGEND
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             LegendItem(color: Colors.blue, text: "Employees"),
//             LegendItem(color: Colors.orange, text: "Visitors"),
//             LegendItem(color: Colors.green, text: "Active"),
//           ],
//         ),
//       ],
//     );
//   }

//   // 🔥 DYNAMIC SECTIONS (HIGHLIGHT ON TAP)
//   List<PieChartSectionData> showingSections() {
//     final data = [
//       {"value": 120.0, "color": Colors.blue, "title": "120"},
//       {"value": 45.0, "color": Colors.orange, "title": "45"},
//       {"value": 18.0, "color": Colors.green, "title": "18"},
//     ];

//     return List.generate(data.length, (i) {
//       final isTouched = i == touchedIndex;

//       final double radius = isTouched ? 60 : 45;
//       final double fontSize = isTouched ? 14 : 11;

//       return PieChartSectionData(
//         value: data[i]["value"] as double,
//         color: data[i]["color"] as Color,
//         title: data[i]["title"] as String,
//         radius: radius,
//         titleStyle: TextStyle(
//           fontSize: fontSize,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       );
//     });
//   }
// }
