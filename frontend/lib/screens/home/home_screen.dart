import 'package:flutter/material.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/navigation.dart';
import '../../widgets/feedback_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'NURA', showBackButton: false, showLogo: true),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const EmptyState(message: 'Home Module Placeholder', icon: Icons.home),
          ],
        ),
      ),
    );
  }
}
