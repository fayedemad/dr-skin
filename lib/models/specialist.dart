class Specialist {
  final String id;
  final String name;
  final String phoneNumber;
  final String specialization;
  final String licenseNumber;
  final String hospital;
  final String bio;
  final String? profileImage;

  Specialist({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.specialization,
    required this.licenseNumber,
    required this.hospital,
    required this.bio,
    this.profileImage,
  });

  Specialist copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? specialization,
    String? licenseNumber,
    String? hospital,
    String? bio,
    String? profileImage,
  }) {
    return Specialist(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      specialization: specialization ?? this.specialization,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      hospital: hospital ?? this.hospital,
      bio: bio ?? this.bio,
      profileImage: profileImage ?? this.profileImage,
    );
  }
} 