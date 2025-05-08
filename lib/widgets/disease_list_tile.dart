import 'package:flutter/material.dart';
import '../models/disease.dart';

class DiseaseListTile extends StatelessWidget {
  final Disease disease;
  final VoidCallback onTap;

  const DiseaseListTile({
    required this.disease,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        'assets/images/placeholder.png',
        width: 48,
        height: 48,
        fit: BoxFit.cover,
      ),
      title: Text(disease.name, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
} 