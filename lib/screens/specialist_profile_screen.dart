import 'package:flutter/material.dart';
import '../models/specialist.dart';
import '../widgets/base_layout.dart';

class SpecialistProfileScreen extends StatelessWidget {
  const SpecialistProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Specialist specialist = ModalRoute.of(context)!.settings.arguments as Specialist;
    return BaseLayout(
      currentRoute: '/specialist_search',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Specialist Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(specialist.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(specialist.specialty, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text('Location:', style: TextStyle(fontWeight: FontWeight.w600)),
              Text(specialist.location),
              const SizedBox(height: 16),
              const Text('Contact:', style: TextStyle(fontWeight: FontWeight.w600)),
              Text(specialist.contact),
              const SizedBox(height: 16),
              const Text('Availability:', style: TextStyle(fontWeight: FontWeight.w600)),
              Text(specialist.availability),
            ],
          ),
        ),
      ),
    );
  }
} 