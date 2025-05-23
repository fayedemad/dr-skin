import 'package:flutter/material.dart';
import '../models/specialist.dart';
import 'api.dart';

class AuthService extends ChangeNotifier {
  Specialist? _currentSpecialist;
  bool _isAuthenticated = false;

  Specialist? get currentSpecialist => _currentSpecialist;
  bool get isAuthenticated => _isAuthenticated;

  // Ready for backend login
  Future<bool> login(String phoneNumber) async {
    // TODO: Replace with real backend call
    // Example:
    // final response = await Api.post('/login', body: {'phone': phoneNumber});
    // if (response.statusCode == 200) { ... }

    await Future.delayed(const Duration(seconds: 1));
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

  Future<bool> updateProfile(Specialist updatedSpecialist) async {
    if (_currentSpecialist == null) return false;
    // TODO: Replace with real backend call
    await Future.delayed(const Duration(seconds: 1));
    _currentSpecialist = updatedSpecialist;
    notifyListeners();
    return true;
  }
} 