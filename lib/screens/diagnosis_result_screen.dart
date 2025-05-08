import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_button.dart';

class DiagnosisResultScreen extends StatelessWidget {
  const DiagnosisResultScreen({super.key});

  Widget _buildImagePreview(dynamic image) {
    if (image == null) return const SizedBox.shrink();
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: kIsWeb
          ? Image.network(
              image.path,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text('Error loading image'),
                  ),
                );
              },
            )
          : Image.file(
              image as File,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text('Error loading image'),
                  ),
                );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamic image = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Result'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildImagePreview(image),
              if (image != null) const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      const Text(
                        'Diagnosis: Melanoma',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Confidence: 92%',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Health Advice:\nPlease consult a dermatologist as soon as possible. Early detection and treatment are crucial.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),
                      CustomButton(
                        icon: Icons.search,
                        text: 'Search for Specialists',
                        onTap: () => Navigator.pushNamed(context, '/specialist_search'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 