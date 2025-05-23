import 'package:flutter/material.dart';
import '../models/specialist.dart';
import '../dummy_data/specialists.dart';
import '../widgets/specialist_list_tile.dart';

class SpecialistSearchScreen extends StatefulWidget {
  const SpecialistSearchScreen({Key? key}) : super(key: key);

  @override
  _SpecialistSearchScreenState createState() => _SpecialistSearchScreenState();
}

class _SpecialistSearchScreenState extends State<SpecialistSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Specialist> _filteredSpecialists = specialists;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSpecialists(String query) {
    setState(() {
      _filteredSpecialists = specialists.where((s) =>
        s.name.toLowerCase().contains(query.toLowerCase()) ||
        s.specialization.toLowerCase().contains(query.toLowerCase()) ||
        s.hospital.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Specialist'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, specialization, or hospital',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _filterSpecialists,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSpecialists.length,
              itemBuilder: (context, index) {
                return SpecialistListTile(
                  specialist: _filteredSpecialists[index],
                  onTap: () {
                    // TODO: Navigate to specialist profile
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 