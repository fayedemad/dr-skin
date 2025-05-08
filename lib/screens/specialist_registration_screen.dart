import 'package:flutter/material.dart';
import '../widgets/base_layout.dart';

class SpecialistRegistrationScreen extends StatefulWidget {
  const SpecialistRegistrationScreen({super.key});

  @override
  _SpecialistRegistrationScreenState createState() => _SpecialistRegistrationScreenState();
}

class _SpecialistRegistrationScreenState extends State<SpecialistRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String specialty = '';
  String contact = '';
  String availability = '';

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      currentRoute: '/specialist_registration',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register as Specialist'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (val) => name = val,
                  validator: (val) => val == null || val.isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Specialty'),
                  onChanged: (val) => specialty = val,
                  validator: (val) => val == null || val.isEmpty ? 'Enter your specialty' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Contact Info'),
                  onChanged: (val) => contact = val,
                  validator: (val) => val == null || val.isEmpty ? 'Enter your contact info' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Availability'),
                  onChanged: (val) => availability = val,
                  validator: (val) => val == null || val.isEmpty ? 'Enter your availability' : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registration submitted (dummy)!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 