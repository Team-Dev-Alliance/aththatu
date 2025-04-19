import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('View Analytics'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sales Pie Chart
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sales',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<String>(
                            value: 'Month',
                            items: ['Day', 'Week', 'Month']
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ))
                                .toList(),
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 150,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: Colors.blue,
                                value: 47,
                                title: '47%',
                                radius: 50,
                                titleStyle: const TextStyle(color: Colors.white),
                              ),
                              PieChartSectionData(
                                color: Colors.orange,
                                value: 28,
                                title: '28%',
                                radius: 50,
                                titleStyle: const TextStyle(color: Colors.white),
                              ),
                              PieChartSectionData(
                                color: Colors.yellow,
                                value: 18,
                                title: '18%',
                                radius: 50,
                                titleStyle: const TextStyle(color: Colors.black),
                              ),
                            ],
                            centerSpaceRadius: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          CircleAvatar(radius: 5, backgroundColor: Colors.blue),
                          SizedBox(width: 8),
                          Text('Item1'),
                          SizedBox(width: 16),
                          CircleAvatar(radius: 5, backgroundColor: Colors.orange),
                          SizedBox(width: 8),
                          Text('Item2'),
                          SizedBox(width: 16),
                          CircleAvatar(radius: 5, backgroundColor: Colors.yellow),
                          SizedBox(width: 8),
                          Text('Item3'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Weekly Sales Area Chart
              Card(
                color: const Color(0xFF1A3C34),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Weekly',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('See details', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      '\$${value.toInt()}',
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const days = ['Mo', 'Tue', 'We', 'Th', 'Fr', 'Sa', 'Su'];
                                    return Text(
                                      days[value.toInt()],
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    );
                                  },
                                ),
                              ),
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  const FlSpot(0, 200),
                                  const FlSpot(1, 300),
                                  const FlSpot(2, 250),
                                  const FlSpot(3, 400),
                                  const FlSpot(4, 350),
                                  const FlSpot(5, 500),
                                  const FlSpot(6, 260),
                                ],
                                isCurved: true,
                                color: Colors.blue,
                                barWidth: 2,
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: Colors.blue.withAlpha(77), // Equivalent to 30% opacity
                                ),
                              ),
                            ],
                            minX: 0,
                            maxX: 6,
                            minY: 0,
                            maxY: 600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '\$2,960.00',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Customer Satisfaction Line Chart
              Card(
                color: const Color(0xFF1A3C34),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Customer Satisfaction',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: const FlTitlesData(
                              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  const FlSpot(0, 3),
                                  const FlSpot(1, 4),
                                  const FlSpot(2, 2),
                                  const FlSpot(3, 5),
                                  const FlSpot(4, 3),
                                  const FlSpot(5, 4),
                                  const FlSpot(6, 3),
                                ],
                                isCurved: true,
                                color: Colors.blue,
                                barWidth: 2,
                                dotData: const FlDotData(show: false),
                              ),
                              LineChartBarData(
                                spots: [
                                  const FlSpot(0, 2),
                                  const FlSpot(1, 3),
                                  const FlSpot(2, 1),
                                  const FlSpot(3, 4),
                                  const FlSpot(4, 2),
                                  const FlSpot(5, 3),
                                  const FlSpot(6, 2),
                                ],
                                isCurved: true,
                                color: Colors.green,
                                barWidth: 2,
                                dotData: const FlDotData(show: false),
                              ),
                            ],
                            minX: 0,
                            maxX: 6,
                            minY: 0,
                            maxY: 5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          CircleAvatar(radius: 5, backgroundColor: Colors.blue),
                          SizedBox(width: 8),
                          Text('Last', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 16),
                          CircleAvatar(radius: 5, backgroundColor: Colors.green),
                          SizedBox(width: 8),
                          Text('This', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Money Flow Line Chart
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Money Flow',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<String>(
                            value: 'Week',
                            items: ['Day', 'Week', 'Month']
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ))
                                .toList(),
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const days = ['Oct', 'Nov', 'Dec', 'Jan'];
                                    return Text(
                                      days[value.toInt()],
                                      style: const TextStyle(color: Colors.black, fontSize: 12),
                                    );
                                  },
                                ),
                              ),
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  const FlSpot(0, 1),
                                  const FlSpot(1, 2),
                                  const FlSpot(2, 1.5),
                                  const FlSpot(3, 2.6),
                                ],
                                isCurved: true,
                                color: Colors.blue,
                                barWidth: 2,
                                dotData: const FlDotData(show: false),
                              ),
                              LineChartBarData(
                                spots: [
                                  const FlSpot(0, 0.5),
                                  const FlSpot(1, 1.5),
                                  const FlSpot(2, 1),
                                  const FlSpot(3, 2),
                                ],
                                isCurved: true,
                                color: Colors.purple,
                                barWidth: 2,
                                dotData: const FlDotData(show: false),
                              ),
                            ],
                            minX: 0,
                            maxX: 3,
                            minY: 0,
                            maxY: 3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '2.60',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                                SizedBox(width: 4),
                                Text('+6.79%', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Sales Summary
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '51,756',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text('Sales'),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                            SizedBox(width: 4),
                            Text('+22.45%', style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}