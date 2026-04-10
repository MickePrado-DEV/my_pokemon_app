enum Gender { male, female, none }

class UserProfile {
  final String name;
  final Gender gender;

  UserProfile({required this.name, required this.gender});

  factory UserProfile.empty() => UserProfile(name: '', gender: Gender.none);
}