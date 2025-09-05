import 'package:byteloop/constant/app_colors.dart';
import 'package:byteloop/model/contest_model.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ContestDetailsScreen extends StatelessWidget {
  final ContestModel contest;

  const ContestDetailsScreen({super.key, required this.contest});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final start = DateTime.fromMillisecondsSinceEpoch(
      contest.startTimeSeconds * 1000,
    );
    final end = start.add(Duration(seconds: contest.durationSeconds));
    final dateFormat = DateFormat('MMM d, hh:mm a'); // 12-hour format

    return Scaffold(
      appBar: AppBar(
        title: Text(contest.name),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: CustomRadialBackground(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contest Logo
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    contest.logo.isNotEmpty
                        ? contest.logo
                        : 'https://sta.codeforces.com/s/95630/images/codeforces-logo-with-telegram.png',
                    width: double.infinity,
                    height: context.height * 0.1,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.code, size: 100),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Contest Name
              Center(
                child: Text(
                  contest.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // Phase & Type
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PHASE ${contest.phase.toUpperCase()}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: contest.phase.toUpperCase() == 'BEFORE'
                          ? Colors.green
                          : contest.phase.toUpperCase() == 'CODING'
                          ? Colors.orange
                          : contest.phase.toUpperCase() == 'FINISHED'
                          ? Colors.red
                          : Colors.white70,
                    ),
                  ),
                  Text(
                    contest.type,
                    style: TextStyle(
                      fontSize: 14,
                      color: contest.type.toUpperCase() == 'VIRTUAL'
                          ? Colors.purple
                          : contest.type.toUpperCase() == 'CF'
                          ? Colors.blue
                          : Colors.white60,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Time Details Card
              Card(
                color: AppColors.authBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow(
                        "Start Time",
                        dateFormat.format(start.toLocal()),
                      ),
                      const SizedBox(height: 8),
                      _infoRow("End Time", dateFormat.format(end.toLocal())),
                      const SizedBox(height: 8),
                      _infoRow(
                        "Duration",
                        "${contest.durationSeconds ~/ 3600}h "
                            "${(contest.durationSeconds % 3600) ~/ 60}m",
                      ),
                      const SizedBox(height: 8),
                      _infoRow("Status", contest.phase.toUpperCase()),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Description Section
              const Text(
                "About Contest",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "This is an official Codeforces contest where participants can "
                "compete and improve their problem-solving skills. "
                "The contest will include algorithmic and data structure challenges. "
                "Each participant is required to follow the Codeforces rules. "
                "Submissions are judged automatically based on correctness and efficiency. "
                "Make sure to read the contest announcements carefully. "
                "Participants can see their rating changes after the contest. "
                "Enjoy the contest and try to solve as many problems as possible.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, height: 1.5),
              ),

              const SizedBox(height: 30),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () => _launchUrl(contest.url),
          icon: const Icon(Icons.open_in_browser),
          label: const Text(
            "View Full Contest",
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            backgroundColor: AppColors.authBgColor.withAlpha(180),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for info row
  Widget _infoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }
}
