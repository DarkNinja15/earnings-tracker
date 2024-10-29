import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticker_assign/app/modules/home/controller/home_controller.dart';
import 'package:ticker_assign/app/modules/shared/constants.dart';
import 'package:ticker_assign/app/modules/shared/widgets/loading_widget.dart';
import 'components/earnings_graph.dart';
import 'components/transcript_view.dart';

class HomeView extends GetView<HomeController> {
  final TextEditingController _tickerController = TextEditingController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Earnings Tracker',style: TextStyle(
        color: AppConstants.lightTextColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),),
        backgroundColor: AppConstants.primaryColor,
        elevation: 2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppConstants.searchBoxBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.shadow.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: FocusScope(
                  child: TextField(
                    controller: _tickerController,
                    decoration: const InputDecoration(
                        hintText: 'Comany ticker (e.g. MSFT)',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: AppConstants.bodyIconColor),
                        contentPadding: EdgeInsets.symmetric(vertical: 15)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode()); // hide keyboard
                  controller.fetchEarningsData(_tickerController.text); // fetch earnings data
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: AppConstants.primaryColor,
                  foregroundColor: AppConstants.buttonForegroundColor,
                  elevation: 5,
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: Loader());
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width,
                  child: controller.earningsData.isEmpty
                      ? Column(
                        children: [
                          Image.asset(AppConstants.noDataImage),
                          const Center(child: Text('No data available!',style: TextStyle(
                            color: AppConstants.darkTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),)),
                        ],
                      )
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
      ),
    );
  }
}
