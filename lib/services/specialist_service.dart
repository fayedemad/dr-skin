import '../models/specialist.dart';
import '../dummy_data/specialists.dart';

class SpecialistService {
  Future<List<Specialist>> fetchSpecialists() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: Replace with HTTP call
    return specialists;
  }
} 