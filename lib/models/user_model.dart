/// User data model representing an authenticated user.
class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    this.name,
    this.phoneNumber,
    this.avatarUrl,
  });

  final String id;
  final String email;
  final String? name;
  final String? phoneNumber;
  final String? avatarUrl;

  /// Creates a [UserModel] from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  /// Converts this [UserModel] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      if (name != null) 'name': name,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
    };
  }

  /// Creates a copy of this [UserModel] with the given fields replaced.
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
