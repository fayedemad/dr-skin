import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/image_upload_screen.dart';
import 'screens/diagnosis_result_screen.dart';
import 'screens/educational_content_screen.dart';
import 'screens/content_detail_screen.dart';
import 'screens/specialist_search_screen.dart';
import 'screens/specialist_profile_screen.dart';
import 'screens/specialist_registration_screen.dart';
import 'screens/specialist_profile_management_screen.dart';
import 'screens/about_screen.dart';
import 'screens/login_screen.dart';
import 'screens/doctor_profile_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  runApp(DrSkinApp(isDarkMode: isDarkMode));
}

class DrSkinApp extends StatefulWidget {
  final bool isDarkMode;
  
  const DrSkinApp({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<DrSkinApp> createState() => _DrSkinAppState();
}

class _DrSkinAppState extends State<DrSkinApp> {
  late bool _isDarkMode;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _toggleTheme() async {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    await _prefs.setBool('isDarkMode', _isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'Dr. Skin',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/doctor_profile': (context) => const DoctorProfileScreen(),
          '/home': (context) => HomeScreen(onThemeToggle: _toggleTheme),
          '/image_upload': (context) => const ImageUploadScreen(),
          '/diagnosis_result': (context) => const DiagnosisResultScreen(),
          '/educational_content': (context) => const EducationalContentScreen(),
          '/content_detail': (context) => const ContentDetailScreen(),
          '/specialist_search': (context) => const SpecialistSearchScreen(),
          '/specialist_profile': (context) => const SpecialistProfileScreen(),
          '/specialist_registration': (context) => const SpecialistRegistrationScreen(),
          '/specialist_profile_management': (context) => const SpecialistProfileManagementScreen(),
          '/about': (context) => const AboutScreen(),
        },
      ),
    );
  }
}
