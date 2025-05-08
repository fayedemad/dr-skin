import 'package:flutter/material.dart';
import '../models/specialist.dart';

class SpecialistListTile extends StatelessWidget {
  final Specialist specialist;
  final VoidCallback onTap;

  const SpecialistListTile({
    required this.specialist,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(specialist.name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('${specialist.specialty} • ${specialist.location}'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
} 