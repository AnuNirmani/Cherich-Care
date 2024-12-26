import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'Chart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Symptom Analysis',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Symptom Tracking Chart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 350, // Increased height to avoid clipping
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: true),
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        axisNameWidget: const Text(
                          'Month',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        axisNameSize: 30, // Increased to give more space
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: 30, // Increased for better spacing
                          getTitlesWidget: (value, _) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('M${value.toInt()}'),
                          ),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        axisNameWidget: const Text(
                          'No of Symptoms',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        axisNameSize: 30, // Increased for better spacing
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: 35, // Increased for longer labels
                          getTitlesWidget: (value, _) => Text(value.toInt().toString()),
                        ),
                      ),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.blue,
                        spots: const [
                          FlSpot(1, 0),
                          FlSpot(2, 3),
                          FlSpot(3, 3),
                          FlSpot(4, 3),
                          FlSpot(5, 3),
                          FlSpot(6, 2),
                          FlSpot(7, 2),
                          FlSpot(8, 2),
                          FlSpot(9, 1),
                          FlSpot(10, 1),
                          FlSpot(11, 0),
                          FlSpot(12, 0),
                        ],
                      ),
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.red,
                        spots: const [
                          FlSpot(1, 0),
                          FlSpot(2, 1),
                          FlSpot(3, 2),
                          FlSpot(4, 4),
                          FlSpot(5, 3),
                          FlSpot(6, 3),
                          FlSpot(7, 2),
                          FlSpot(8, 1),
                          FlSpot(9, 0),
                          FlSpot(10, 0),
                          FlSpot(11, 0),
                          FlSpot(12, 0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(Colors.blue, 'Left Cherry'),
                  const SizedBox(width: 20),
                  _buildLegendItem(Colors.red, 'Right Cherry'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
