import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/services/audio_service.dart';

class SosFamilyAlertedScreen extends StatefulWidget {
  const SosFamilyAlertedScreen({super.key});

  @override
  State<SosFamilyAlertedScreen> createState() => _SosFamilyAlertedScreenState();
}

class _SosFamilyAlertedScreenState extends State<SosFamilyAlertedScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Play success chime sound once
    AudioService().playSosSuccessSound();
    
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.pushReplacement('/sos-active-tracking');
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    // Stop the success sound if navigated away
    AudioService().stopSosSuccessSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : AppColors.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  const Icon(Icons.security, color: AppColors.error, size: 80),
                  const SizedBox(height: AppSpacing.md),
                  Text('Status:', style: AppTypography.bodyMedium.copyWith(color: isDark ? Colors.white70 : AppColors.textPrimary)),
                  Text('ALERT SENT', style: AppTypography.h1.copyWith(color: isDark ? Colors.white : AppColors.textPrimary)),
                  const SizedBox(height: AppSpacing.xxl),
                  
                  _buildContact(context, 'Mom', '10:32 AM'),
                  const Divider(),
                  _buildContact(context, 'Dad', '10:32 AM'),
                  const Divider(),
                  _buildContact(context, 'Sarah', '10:32 AM'),
                ],
              ),
            ),
            
            // Floating Notification
            Positioned(
              right: 20,
              bottom: 100,
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF121625) : AppColors.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSpacing.radiusLg),
                    bottomLeft: Radius.circular(AppSpacing.radiusLg),
                    topRight: Radius.circular(AppSpacing.radiusLg),
                    bottomRight: Radius.zero,
                  ),
                  border: Border.all(color: isDark ? Colors.white24 : Colors.transparent),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.white10 : Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('ALERT:', style: AppTypography.bodySmall.copyWith(color: isDark ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold)),
                    Text('[Sarah\'s needs help!]\n[Link to location]\n@ 10:32 AM', style: AppTypography.bodySmall.copyWith(color: isDark ? Colors.white70 : Colors.black)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContact(BuildContext context, String name, String time) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isDark ? Colors.white12 : AppColors.border,
            child: Text(name[0], style: AppTypography.bodyLarge.copyWith(color: isDark ? Colors.white : AppColors.textPrimary)),
          ),
          const SizedBox(width: AppSpacing.lg),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
              Text(time, style: AppTypography.bodySmall.copyWith(color: isDark ? Colors.white60 : AppColors.textSecondary)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success),
            child: const Icon(Icons.check, color: AppColors.textInverse, size: 16),
          ),
        ],
      ),
    );
  }
}
