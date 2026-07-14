import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nura_frontend/screens/onboarding/onboarding_screen.dart';
import 'package:nura_frontend/screens/auth/login_screen.dart';
import 'package:nura_frontend/screens/auth/register_screen.dart';
import 'package:nura_frontend/screens/health/health_dashboard_screen.dart';
import 'package:nura_frontend/screens/wellness/health_wellness_screen.dart';
import 'package:nura_frontend/screens/medication/medication_dashboard_screen.dart';

void main() {
  // Test 1: Onboarding Screen Widget test
  testWidgets('Onboarding Screen UI test - renders slides and action buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: OnboardingScreen(),
        ),
      ),
    );

    // Verify brand header and first slide title
    expect(find.text('NURA'), findsOneWidget);
    expect(find.text('Welcome to NURA'), findsOneWidget);

    // Verify action buttons are present
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    // Tap Next to advance
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Verify second slide content is visible
    expect(find.text('Medication & Tracking'), findsOneWidget);
  });

  // Test 2: Login Screen Widget test
  testWidgets('Login Screen UI test - renders form inputs and sign-in actions', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    // Verify title and prompt texts
    expect(find.text('WELCOME BACK!'), findsOneWidget);
    
    // Verify TextFields are present (by checking hints)
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Verify Sign In and Sign Up buttons are rendered
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });

  // Test 3: Register Screen Widget test
  testWidgets('Register Screen UI test - renders registration form inputs', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: RegisterScreen(),
        ),
      ),
    );

    // Verify registration titles
    expect(find.text('GET STARTED FREE'), findsOneWidget);
    expect(find.text('Free Forever. No Credit Card Needed.'), findsOneWidget);

    // Verify TextFields hints
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);

    // Verify Sign Up submit button
    expect(find.text('Create Account'), findsOneWidget);
  });

  // Test 4: Health Dashboard Screen Widget test
  testWidgets('Health Dashboard UI test - renders vitals tracking cards', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HealthDashboardScreen(),
        ),
      ),
    );

    // Verify title header
    expect(find.text('Vitals'), findsOneWidget);
    expect(find.text('Your Personal Health Tracker'), findsOneWidget);

    // Verify Vitals Category cards are present
    expect(find.text('Blood Pressure'), findsOneWidget);
    expect(find.text('Blood Sugar'), findsOneWidget);
    expect(find.text('Weight'), findsOneWidget);
    expect(find.text('Symptoms'), findsOneWidget);
    expect(find.text('Medicines'), findsOneWidget);
  });

  // Test 5: Health & Wellness Screen Widget test
  testWidgets('Health Wellness Screen UI test - renders timeline and switches tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HealthWellnessScreen(),
        ),
      ),
    );

    // Verify title and top banner
    expect(find.text('Health & Wellness'), findsOneWidget);
    expect(find.text('AI Health & Care Companion'), findsOneWidget);

    // Verify Tab headers are present (finds at least the tab bar title)
    expect(find.text('AI Health Timeline'), findsAtLeastNWidgets(1));
    expect(find.text('Health Trends & Vitals'), findsOneWidget);

    // Tap on Health Trends tab (select the one in tab bar)
    await tester.tap(find.text('Health Trends & Vitals'));
    await tester.pumpAndSettle();

    // Verify that status cards inside Health Trends are rendered
    expect(find.text('Heart Health'), findsOneWidget);
    expect(find.text('Sleep Quality'), findsOneWidget);
  });

  // Test 6: Medication Dashboard Screen Widget test
  testWidgets('Medication Dashboard UI test - renders meds reminder cards', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MedicationDashboardScreen(),
        ),
      ),
    );

    // Verify title and top reminder banner
    expect(find.text('Medication Reminder'), findsOneWidget);
    expect(find.text('Daily Medication Tracker'), findsOneWidget);

    // Verify Lisinopril medication is rendered (both in list and timeline)
    expect(find.text('Lisinopril 10mg'), findsNWidgets(2));
  });
}
