import 'package:flutter/material.dart';
import '../widgets/base_layout.dart';

class SpecialistProfileManagementScreen extends StatefulWidget {
  const SpecialistProfileManagementScreen({super.key});

  @override
  _SpecialistProfileManagementScreenState createState() => _SpecialistProfileManagementScreenState();
}

class _SpecialistProfileManagementScreenState extends State<SpecialistProfileManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = 'Dr. Jane Doe';
  String specialty = 'Dermatologist';
  String contact = 'jane.doe@email.com';
  String availability = 'Mon-Fri, 9am-5pm';

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      currentRoute: '/specialist_registration',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (val) => name = val,
                  validator: (val) => val == null || val.isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: specialty,
                  decoration: const InputDecoration(labelText: 'Specialty'),
                  onChanged: (val) => specialty = val,
                  validator: (val) => val == null || val.isEmpty ? 'Enter your specialty' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: contact,
                  decoration: const InputDecoration(labelText: 'Contact Info'),
                  onChanged: (val) => contact = val,
                  validator: (val) => val == null || val.isEmpty ? 'Enter your contact info' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: availability,
                  decoration: const InputDecoration(labelText: 'Availability'),
                  onChanged: (val) => availability = val,
                  validator: (val) => val == null || val.isEmpty ? 'Enter your availability' : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save Changes'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile updated (dummy)!')),
                      );
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