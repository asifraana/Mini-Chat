class UserModel {
  final int id;
  final String name;
  final bool online;
  final String status;

  UserModel({
    required this.id,
    required this.name,
    required this.online,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final isOnline = json['id'] % 2 == 0;

    return UserModel(
      id: json['id'],
      name: '${json['firstName']} ${json['lastName']}',
      online: isOnline,
      status: isOnline ? 'Online' : 'Offline',
    );
  }
}
