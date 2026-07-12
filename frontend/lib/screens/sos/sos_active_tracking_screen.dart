import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/map_placeholder.dart';
import '../../widgets/location_ripple.dart';
import '../../core/services/audio_service.dart';

class SosActiveTrackingScreen extends StatelessWidget {
  const SosActiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          const MapPlaceholder(),
          
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '(( LIVE TRACKING ACTIVE ))',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.textInverse, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          
          Center(
            child: LocationRipple(
              color: AppColors.error,
              size: 200,
            ),
          ),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF121625) : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                border: Border.all(color: isDark ? Colors.white24 : Colors.transparent),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.white10 : Colors.black26, 
                    blurRadius: 10, 
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.errorDark, // Dark Red
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                      ),
                    ),
                    onPressed: () {
                      AudioService().playSosCancelSound();
                      context.go('/home');
                    },
                    child: Text('Cancel Emergency', style: AppTypography.button.copyWith(color: AppColors.textInverse)),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Family Members Notified', 
                      style: AppTypography.h3.copyWith(color: isDark ? Colors.white : Colors.black),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  
                  _buildTrackingContact(context, 'Mom'),
                  _buildTrackingContact(context, 'Sarah'),
                  
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Emergency Services (911) may be dispatched\nbased on settings.',
                    style: AppTypography.bodySmall.copyWith(color: isDark ? Colors.white70 : AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingContact(BuildContext context, String name) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: isDark ? Colors.white12 : AppColors.border,
            child: Icon(Icons.person, size: 20, color: isDark ? Colors.white : AppColors.textInverse),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(name, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          const Spacer(),
          const Icon(Icons.wifi_tethering, color: AppColors.success, size: 20),
        ],
      ),
    );
  }
}
