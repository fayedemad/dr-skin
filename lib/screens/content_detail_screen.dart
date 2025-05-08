import 'package:flutter/material.dart';
import '../models/disease.dart';
import '../widgets/base_layout.dart';

class ContentDetailScreen extends StatelessWidget {
  const ContentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Disease disease = ModalRoute.of(context)!.settings.arguments as Disease;
    return BaseLayout(
      currentRoute: '/educational_content',
      child: Scaffold(
        appBar: AppBar(
          title: Text(disease.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/placeholder.png',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24),
              Text(
                disease.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                disease.description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 