import 'package:flutter/material.dart';
import '../dummy_data/specialists.dart';
import '../widgets/search_bar.dart';
import '../widgets/specialist_list_tile.dart';
import '../widgets/base_layout.dart';

class SpecialistSearchScreen extends StatefulWidget {
  const SpecialistSearchScreen({super.key});

  @override
  _SpecialistSearchScreenState createState() => _SpecialistSearchScreenState();
}

class _SpecialistSearchScreenState extends State<SpecialistSearchScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredSpecialists = specialists
        .where((s) =>
            s.name.toLowerCase().contains(query.toLowerCase()) ||
            s.specialty.toLowerCase().contains(query.toLowerCase()) ||
            s.location.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return BaseLayout(
      currentRoute: '/specialist_search',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Specialists'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_add_alt_1),
              onPressed: () => Navigator.pushNamed(context, '/specialist_registration'),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBarWidget(
                hintText: 'Search by name, specialty, or location...',
                onChanged: (val) => setState(() => query = val),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSpecialists.length,
                itemBuilder: (context, index) {
                  final specialist = filteredSpecialists[index];
                  return SpecialistListTile(
                    specialist: specialist,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/specialist_profile',
                      arguments: specialist,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 