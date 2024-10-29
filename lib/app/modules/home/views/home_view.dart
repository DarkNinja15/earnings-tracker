import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticker_assign/app/modules/home/controller/home_controller.dart';
import 'components/earnings_graph.dart';
import 'components/transcript_view.dart';

class HomeView extends GetView<HomeController> {
  final TextEditingController _tickerController = TextEditingController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Earnings Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tickerController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Company Ticker',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchEarningsData(_tickerController.text),
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: controller.earningsData.isEmpty
                    ? const Center(child: Text('No data available'))
                    : EarningsGraph(data: controller.earningsData),
              );
            }),
            Obx(() {
              if (controller.selectedTranscript.value != null) {
                return const TranscriptView();
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}