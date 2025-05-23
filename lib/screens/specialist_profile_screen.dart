import 'package:flutter/material.dart';
import '../models/specialist.dart';
import '../services/auth_service.dart';
import '../widgets/base_layout.dart';
import 'package:provider/provider.dart';

class SpecialistProfileScreen extends StatefulWidget {
  final Specialist specialist;

  const SpecialistProfileScreen({
    Key? key,
    required this.specialist,
  }) : super(key: key);

  @override
  _SpecialistProfileScreenState createState() => _SpecialistProfileScreenState();
}

class _SpecialistProfileScreenState extends State<SpecialistProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _specializationController;
  late TextEditingController _licenseController;
  late TextEditingController _hospitalController;
  late TextEditingController _bioController;
  bool _isEditing = false;
  bool _isLoading = false;
  late bool _isOwnProfile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.specialist.name);
    _phoneController = TextEditingController(text: widget.specialist.phoneNumber);
    _specializationController = TextEditingController(text: widget.specialist.specialization);
    _licenseController = TextEditingController(text: widget.specialist.licenseNumber);
    _hospitalController = TextEditingController(text: widget.specialist.hospital);
    _bioController = TextEditingController(text: widget.specialist.bio);
    
    // Check if this is the logged-in specialist's profile
    final authService = Provider.of<AuthService>(context, listen: false);
    _isOwnProfile = authService.isAuthenticated && 
                   authService.currentSpecialist?.id == widget.specialist.id;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _specializationController.dispose();
    _licenseController.dispose();
    _hospitalController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (!_isEditing) {
      setState(() => _isEditing = true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final updatedSpecialist = Specialist(
        id: widget.specialist.id,
        name: _nameController.text,
        phoneNumber: _phoneController.text,
        specialization: _specializationController.text,
        licenseNumber: _licenseController.text,
        hospital: _hospitalController.text,
        bio: _bioController.text,
        profileImage: widget.specialist.profileImage,
      );

      final success = await authService.updateProfile(updatedSpecialist);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
        setState(() => _isEditing = false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      currentRoute: '/specialist_profile',
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isOwnProfile ? 'My Profile' : 'Specialist Profile'),
          actions: [
            if (_isOwnProfile)
              IconButton(
                icon: Icon(_isEditing ? Icons.save : Icons.edit),
                onPressed: _isLoading ? null : _updateProfile,
              ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: widget.specialist.profileImage != null
                    ? NetworkImage(widget.specialist.profileImage!)
                    : null,
                child: widget.specialist.profileImage == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              const SizedBox(height: 24),
              _buildProfileField(
                label: 'Name',
                controller: _nameController,
                icon: Icons.person_outline,
                enabled: _isEditing && _isOwnProfile,
              ),
              const SizedBox(height: 16),
              _buildProfileField(
                label: 'Phone',
                controller: _phoneController,
                icon: Icons.phone_outlined,
                enabled: _isEditing && _isOwnProfile,
              ),
              const SizedBox(height: 16),
              _buildProfileField(
                label: 'Specialization',
                controller: _specializationController,
                icon: Icons.medical_information_outlined,
                enabled: _isEditing && _isOwnProfile,
              ),
              const SizedBox(height: 16),
              _buildProfileField(
                label: 'License Number',
                controller: _licenseController,
                icon: Icons.badge_outlined,
                enabled: _isEditing && _isOwnProfile,
              ),
              const SizedBox(height: 16),
              _buildProfileField(
                label: 'Hospital/Clinic',
                controller: _hospitalController,
                icon: Icons.local_hospital_outlined,
                enabled: _isEditing && _isOwnProfile,
              ),
              const SizedBox(height: 16),
              _buildProfileField(
                label: 'Bio',
                controller: _bioController,
                icon: Icons.description_outlined,
                enabled: _isEditing && _isOwnProfile,
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              if (_isEditing && _isOwnProfile)
                ElevatedButton(
                  onPressed: _isLoading ? null : _updateProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool enabled,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
} 