import 'package:flutter/material.dart';
import '../models/doctor.dart';

class AuthService extends ChangeNotifier {
  Doctor? _currentDoctor;
  bool _isAuthenticated = false;

  Doctor? get currentDoctor => _currentDoctor;
  bool get isAuthenticated => _isAuthenticated;

  // Mock login - accepts any email/password
  Future<bool> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock successful login
    _currentDoctor = Doctor(
      id: '1',
      name: 'Dr. John Doe',
      email: email,
      specialization: 'Dermatology',
      licenseNumber: 'MD123456',
      phoneNumber: '+1234567890',
      hospital: 'City General Hospital',
      bio: 'Experienced dermatologist with over 10 years of practice.',
    );
    _isAuthenticated = true;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentDoctor = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<bool> updateProfile({
    String? name,
    String? phoneNumber,
    String? hospital,
    String? bio,
    String? profileImageUrl,
  }) async {
    if (_currentDoctor == null) return false;

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _currentDoctor = _currentDoctor!.copyWith(
      name: name,
      phoneNumber: phoneNumber,
      hospital: hospital,
      bio: bio,
      profileImageUrl: profileImageUrl,
    );
    notifyListeners();
    return true;
  }
} 