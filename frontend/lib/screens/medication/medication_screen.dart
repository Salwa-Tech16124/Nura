import 'package:flutter/material.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/navigation.dart';
import '../../widgets/feedback_states.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Medication', showBackButton: false),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const EmptyState(message: 'Medication Module Placeholder', icon: Icons.medication),
          ],
        ),
      ),
    );
  }
}
