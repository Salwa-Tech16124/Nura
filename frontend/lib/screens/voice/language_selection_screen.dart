import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'Español';

  void _selectLanguage(String language, BuildContext context) {
    setState(() {
      _selectedLanguage = language;
    });
    // Temporary navigation to the next screen for testing
    Future.delayed(const Duration(milliseconds: 300), () {
      if (context.mounted) {
        context.push('/voice-call');
      }
    });
  }

  Widget _buildCard(String flag, String lang, String sub, BuildContext context) {
    final isSelected = _selectedLanguage == lang;
    return GestureDetector(
      onTap: () => _selectLanguage(lang, context),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC3F3C0) : Colors.white, // Green active, white inactive
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: isSelected ? 2.2 : 1.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: isSelected ? const Offset(2, 4) : const Offset(1, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(flag, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: AppSpacing.sm),
            Text(
              lang,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 16),
            ),
            Text(
              sub,
              style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F1F5), // Light sky-blue background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Choose Your',
                style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Language',
                style: TextStyle(color: Color(0xFF1E244A), fontSize: 32, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: AppSpacing.xxl),
              
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.9,
                  children: [
                    _buildCard('🇺🇸', 'English', '(US)', context),
                    _buildCard('🇲🇽', 'Español', 'Mexico', context),
                    _buildCard('🇲🇽', 'Español', 'Mexico', context), 
                    _buildCard('🇫🇷', 'Français', 'France', context),
                    _buildCard('🇨🇳', '中文', 'Mandarin', context),
                    _buildCard('🇮🇳', 'हिन्दी', 'Hindi', context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
