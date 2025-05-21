class UserModel {
  String? id;
  String? fullname;
  String? username;
  String? email;
  String? fcmToken;
  String? phoneNumber;

  UserModel({
    this.id,
    this.fullname,
    this.username,
    this.email,
    this.fcmToken,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["firebase_id"] as String?,
        fullname: json["fullname"] as String?,
        username: json["username"] as String?,
        email: json["email"] as String?,
        fcmToken: json["fcm_token"] as String?,
        phoneNumber: json["mobile_number"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "firebase_id": id,
        "fullname": fullname,
        "username": username,
        "email": email,
        "fcm_token": fcmToken,
        "mobile_number": phoneNumber,
      };
}
