import 'package:benchmark_encrypt_decrypt/utils/number_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/benchmark_data.dart';
import 'home_page_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final homePageC = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Benchmark")),
      body: SingleChildScrollView(
        child: GetBuilder<HomePageController>(
          builder: (_) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                (homePageC.listDataWrite.isEmpty ||
                        homePageC.listDataWriteEncrypted.isEmpty ||
                        homePageC.isLoading == true)
                    ? const SizedBox()
                    : SfCartesianChart(
                        title: ChartTitle(text: "Write"),
                        legend: Legend(
                          isVisible: true,
                          position: LegendPosition.top,
                        ),
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: homePageC.maxWriteValue,
                          interval: 100,
                          title: AxisTitle(text: "(ms)"),
                        ),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<BenchmarkData, String>>[
                          ColumnSeries<BenchmarkData, String>(
                            dataSource: homePageC.listDataWrite,
                            xValueMapper: (data, _) => data.testCount,
                            yValueMapper: (data, _) => data.result,
                            name: 'Not Encrypted',
                            color: Colors.red,
                          ),
                          ColumnSeries<BenchmarkData, String>(
                            dataSource: homePageC.listDataWriteEncrypted,
                            xValueMapper: (data, _) => data.testCount,
                            yValueMapper: (data, _) => data.result,
                            name: 'Encrypted',
                            color: Colors.blue,
                          )
                        ],
                      ),
                (homePageC.listDataWrite.isEmpty ||
                        homePageC.listDataWriteEncrypted.isEmpty ||
                        homePageC.isLoading == true)
                    ? const SizedBox()
                    : const DataWrite(),
                const SizedBox(
                  height: 24,
                ),
                (homePageC.listDataRead.isEmpty ||
                        homePageC.listDataReadEncrypted.isEmpty ||
                        homePageC.isLoading == true)
                    ? const SizedBox()
                    : SfCartesianChart(
                        title: ChartTitle(text: "Read"),
                        legend: Legend(
                          isVisible: true,
                          position: LegendPosition.top,
                        ),
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: homePageC.maxReadValue,
                          interval: 100,
                          title: AxisTitle(text: "(ms)"),
                        ),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<BenchmarkData, String>>[
                          ColumnSeries<BenchmarkData, String>(
                            dataSource: homePageC.listDataRead,
                            xValueMapper: (data, _) => data.testCount,
                            yValueMapper: (data, _) => data.result,
                            name: 'Not Encrypted',
                            color: Colors.amber,
                          ),
                          ColumnSeries<BenchmarkData, String>(
                            dataSource: homePageC.listDataReadEncrypted,
                            xValueMapper: (data, _) => data.testCount,
                            yValueMapper: (data, _) => data.result,
                            name: 'Encrypted',
                            color: Colors.green,
                          )
                        ],
                      ),
                (homePageC.listDataRead.isEmpty ||
                        homePageC.listDataReadEncrypted.isEmpty ||
                        homePageC.isLoading == true)
                    ? const SizedBox()
                    : const DataRead(),
                const SizedBox(
                  height: 24,
                ),
                (homePageC.isLoading)
                    ? const Center(child: Text("Loading..."))
                    : Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            homePageC.startBenchmark();
                          },
                          child: const Text("Start Test"),
                        ),
                      ),
                const SizedBox(
                  height: 48,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> assa() {
    return [];
  }
}

class DataWrite extends StatelessWidget {
  const DataWrite({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Avg. write time: "),
        Text(
          "${controller.avgWrite.roundToTwo()} ms",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const Text("Avg. write + encrypt time: "),
        Text(
          "${controller.avgWriteE.roundToTwo()} ms",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class DataRead extends StatelessWidget {
  const DataRead({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Avg. read time: "),
        Text(
          "${controller.avgRead.roundToTwo()} ms",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const Text("Avg. read + decrypt time: "),
        Text(
          "${controller.avgReadE.roundToTwo()} ms",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
