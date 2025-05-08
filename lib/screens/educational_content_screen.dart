import 'package:flutter/material.dart';
import '../dummy_data/diseases.dart';
import '../widgets/search_bar.dart';
import '../widgets/disease_list_tile.dart';
import '../widgets/base_layout.dart';

class EducationalContentScreen extends StatefulWidget {
  const EducationalContentScreen({super.key});

  @override
  _EducationalContentScreenState createState() => _EducationalContentScreenState();
}

class _EducationalContentScreenState extends State<EducationalContentScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredDiseases = diseases
        .where((d) => d.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return BaseLayout(
      currentRoute: '/educational_content',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Educational Content'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBarWidget(
                hintText: 'Search skin diseases...',
                onChanged: (val) => setState(() => query = val),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDiseases.length,
                itemBuilder: (context, index) {
                  final disease = filteredDiseases[index];
                  return DiseaseListTile(
                    disease: disease,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/content_detail',
                      arguments: disease,
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