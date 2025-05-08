import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/base_layout.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;
  
  const HomeScreen({Key? key, required this.onThemeToggle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return BaseLayout(
      currentRoute: '/home',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dr. Skin'),
          actions: [
            IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: onThemeToggle,
            ),
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () => Navigator.pushNamed(context, '/about'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.medical_services,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to Dr. Skin',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Your AI-powered skin health companion',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              CustomButton(
                icon: Icons.camera_alt,
                text: 'Upload/Capture Image for Diagnosis',
                onTap: () => Navigator.pushNamed(context, '/image_upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 