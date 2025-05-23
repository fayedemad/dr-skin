class Doctor {
  final String id;
  final String name;
  final String email;
  final String specialization;
  final String licenseNumber;
  final String phoneNumber;
  final String hospital;
  final String bio;
  final String profileImageUrl;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.specialization,
    required this.licenseNumber,
    required this.phoneNumber,
    required this.hospital,
    required this.bio,
    this.profileImageUrl = '',
  });

  Doctor copyWith({
    String? id,
    String? name,
    String? email,
    String? specialization,
    String? licenseNumber,
    String? phoneNumber,
    String? hospital,
    String? bio,
    String? profileImageUrl,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      specialization: specialization ?? this.specialization,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      hospital: hospital ?? this.hospital,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
} 