import os

def fix_imports(filepath, depth):
    with open(filepath, 'r') as f:
        content = f.read()
    
    prefix = '../' * depth
    import_stmt = f"import '{prefix}widgets/navigation.dart';"
    
    if import_stmt not in content:
        lines = content.split('\n')
        last_import = -1
        for i, line in enumerate(lines):
            if line.startswith('import '):
                last_import = i
        
        if last_import != -1:
            lines.insert(last_import + 1, import_stmt)
            
        with open(filepath, 'w') as f:
            f.write('\n'.join(lines))

screens_to_fix = [
    'screens/reports/report_dashboard_screen.dart',
    'screens/reports/weekly_report_screen.dart',
    'screens/reports/monthly_report_screen.dart',
    'screens/reports/ai_health_summary_screen.dart',
    'screens/reports/doctor_summary_screen.dart',
    'screens/reports/share_report_screen.dart',
    'screens/profile/health_profile_screen.dart',
    'screens/profile/family_caregivers_screen.dart',
    'screens/profile/medical_records_screen.dart',
    'screens/profile/settings_preferences_screen.dart',
    'screens/profile/privacy_security_screen.dart',
    'screens/profile/about_nura_screen.dart',
    'screens/profile/profile_screen.dart'
]

for f in screens_to_fix:
    path = os.path.join('lib', f)
    if os.path.exists(path):
        fix_imports(path, 2)
