import 'package:flutter/material.dart';
import '../models/specialist.dart';

class AuthService extends ChangeNotifier {
  Specialist? _currentSpecialist;
  bool _isAuthenticated = false;

  Specialist? get currentSpecialist => _currentSpecialist;
  bool get isAuthenticated => _isAuthenticated;

  // Mock login - accepts any phone number
  Future<bool> login(String phoneNumber) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock successful login
    _currentSpecialist = Specialist(
      id: '1',
      name: 'Dr. John Doe',
      phoneNumber: phoneNumber,
      specialization: 'Dermatology',
      licenseNumber: 'MD123456',
      hospital: 'City General Hospital',
      bio: 'Experienced dermatologist with over 10 years of practice.',
    );
    _isAuthenticated = true;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentSpecialist = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<bool> updateProfile({
    String? name,
    String? hospital,
    String? bio,
    String? profileImageUrl,
  }) async {
    if (_currentSpecialist == null) return false;

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _currentSpecialist = _currentSpecialist!.copyWith(
      name: name,
      hospital: hospital,
      bio: bio,
      profileImage: profileImageUrl,
    );
    notifyListeners();
    return true;
  }
} 