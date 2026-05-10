import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    final int id;
    final String employeeId;
    final String role;
    final String rfidUid;
    final int isActive;
    final String name;
    final String email;

    User({
        required this.id,
        required this.employeeId,
        required this.role,
        required this.rfidUid,
        required this.isActive,
        required this.name,
        required this.email,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        employeeId: json["employee_id"],
        role: json["role"],
        rfidUid: json["rfid_uid"],
        isActive: json["is_active"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "role": role,
        "rfid_uid": rfidUid,
        "is_active": isActive,
        "name": name,
        "email": email,
    };
}
