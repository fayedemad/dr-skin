import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    return MaterialApp(
      title: 'Dr. Skin',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(onThemeToggle: _toggleTheme),
        '/image_upload': (context) => ImageUploadScreen(),
        '/diagnosis_result': (context) => DiagnosisResultScreen(),
        '/educational_content': (context) => EducationalContentScreen(),
        '/content_detail': (context) => ContentDetailScreen(),
        '/specialist_search': (context) => SpecialistSearchScreen(),
        '/specialist_profile': (context) => SpecialistProfileScreen(),
        '/specialist_registration': (context) => SpecialistRegistrationScreen(),
        '/specialist_profile_management': (context) => SpecialistProfileManagementScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
