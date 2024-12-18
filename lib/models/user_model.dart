class UserModel {
  final String id;
  final String username;
  final String email;
  final String? profilePicture;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.profilePicture,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      profilePicture: map['profilePicture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profilePicture': profilePicture,
    };
  }

  UserModel copyWith({String? profilePicture}) {
    return UserModel(
      id: id,
      username: username,
      email: email,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}