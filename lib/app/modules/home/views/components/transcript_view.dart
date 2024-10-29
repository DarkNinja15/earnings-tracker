import 'package:flutter/material.dart';
import 'package:ticker_assign/app/data/models/transcript_model.dart';

class TranscriptView extends StatelessWidget {
  final TranscriptData transcript;

  const TranscriptView({super.key, required this.transcript});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Text(transcript.transcript),
      ),
    );
  }
}