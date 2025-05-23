import 'package:flutter/material.dart';
import '../models/specialist.dart';
import '../services/specialist_service.dart';
import '../widgets/specialist_list_tile.dart';
import '../widgets/base_layout.dart';

class SpecialistSearchScreen extends StatefulWidget {
  const SpecialistSearchScreen({Key? key}) : super(key: key);

  @override
  _SpecialistSearchScreenState createState() => _SpecialistSearchScreenState();
}

class _SpecialistSearchScreenState extends State<SpecialistSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SpecialistService _service = SpecialistService();
  List<Specialist> _allSpecialists = [];
  List<Specialist> _filteredSpecialists = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchSpecialists();
  }

  Future<void> _fetchSpecialists() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final specialists = await _service.fetchSpecialists();
      setState(() {
        _allSpecialists = specialists;
        _filteredSpecialists = specialists;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load specialists.';
        _isLoading = false;
      });
    }
  }

  void _filterSpecialists(String query) {
    setState(() {
      _filteredSpecialists = _allSpecialists.where((s) =>
        s.name.toLowerCase().contains(query.toLowerCase()) ||
        s.specialization.toLowerCase().contains(query.toLowerCase()) ||
        s.hospital.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      currentRoute: '/specialist_search',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find a Specialist'),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!))
                : Column(
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
                                Navigator.pushNamed(
                                  context,
                                  '/specialist_profile',
                                  arguments: _filteredSpecialists[index],
                                );
                              },
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