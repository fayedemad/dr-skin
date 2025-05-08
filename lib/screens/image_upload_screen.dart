import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../widgets/custom_button.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _captureImage() async {
    try {
      setState(() => _isLoading = true);
      
      final XFile? capturedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 800,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (capturedFile != null) {
        setState(() {
          _image = capturedFile;
          _isLoading = false;
        });
        
        // Convert XFile to File for mobile or keep as XFile for web
        final dynamic imageToPass = kIsWeb ? capturedFile : File(capturedFile.path);
        
        Navigator.pushNamed(
          context, 
          '/diagnosis_result',
          arguments: imageToPass,
        );
      } else {
        setState(() => _isLoading = false);
      }
    } on Exception catch (e) {
      setState(() => _isLoading = false);
      String errorMessage = 'Error capturing image';
      if (e.toString().contains('permission')) {
        errorMessage = 'Please grant camera permission to capture photos';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _uploadImage() async {
    try {
      setState(() => _isLoading = true);
      
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
          _isLoading = false;
        });
        
        // Convert XFile to File for mobile or keep as XFile for web
        final dynamic imageToPass = kIsWeb ? pickedFile : File(pickedFile.path);
        
        Navigator.pushNamed(
          context, 
          '/diagnosis_result',
          arguments: imageToPass,
        );
      } else {
        setState(() => _isLoading = false);
      }
    } on Exception catch (e) {
      setState(() => _isLoading = false);
      String errorMessage = 'Error uploading image';
      if (e.toString().contains('permission')) {
        errorMessage = 'Please grant storage permission to upload photos';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Widget _buildImagePreview() {
    if (_image == null) return const SizedBox.shrink();
    
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: kIsWeb
              ? Image.network(
                  _image!.path,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text('Error loading image'),
                      ),
                    );
                  },
                )
              : Image.file(
                  File(_image!.path),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text('Error loading image'),
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Image selected successfully!',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload or Capture Image'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 48,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Capture New Photo',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Take a clear photo of the affected area',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            icon: Icons.camera_alt,
                            text: 'Open Camera',
                            onTap: _captureImage,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.photo_library,
                            size: 48,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Upload Existing Photo',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Select a photo from your gallery',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            icon: Icons.photo_library,
                            text: 'Choose from Gallery',
                            onTap: _uploadImage,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_image != null) ...[
                    const SizedBox(height: 24),
                    _buildImagePreview(),
                  ],
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
} 