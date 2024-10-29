import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticker_assign/app/modules/home/controller/transcript_controller.dart';
import 'package:ticker_assign/app/modules/shared/constants.dart';
import 'package:ticker_assign/app/modules/shared/widgets/loading_widget.dart';

// This is the view for the transcript screen. It displays the earnings transcript for a company.
class TranscriptView extends GetView<TranscriptController> {
  const TranscriptView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text('${Get.arguments['ticker']} Earnings Transcript', style: const TextStyle(
          color: AppConstants.lightTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: AppConstants.primaryColor,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios_new,color: AppConstants.appBarIconsColor,)),
      ),
      
      // This is the body of the transcript screen. It displays the earnings transcript for a company.
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: Loader());
        }
        
        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.error.value,
                  style: const TextStyle(color: AppConstants.errorColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchTranscript(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Q${Get.arguments['quarter']} ${Get.arguments['year']} Earnings Call',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              Text(
                controller.transcript.value.transcript,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        );
      }),
    );
  }
}