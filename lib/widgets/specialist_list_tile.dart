import 'package:flutter/material.dart';
import '../models/specialist.dart';

class SpecialistListTile extends StatelessWidget {
  final Specialist specialist;
  final VoidCallback onTap;

  const SpecialistListTile({
    Key? key,
    required this.specialist,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: (specialist.profileImage != null && specialist.profileImage!.isNotEmpty)
            ? NetworkImage(specialist.profileImage!)
            : null,
        child: (specialist.profileImage == null || specialist.profileImage!.isEmpty)
            ? const Icon(Icons.person)
            : null,
      ),
      title: Text(specialist.name),
      subtitle: Text('${specialist.specialization} • ${specialist.hospital}'),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 