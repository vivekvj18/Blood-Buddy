class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? createdAt;
  String? displayName;

  UserModel({this.uid, this.email, this.firstName, this.createdAt, this.displayName});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      createdAt: map['createdAt'],
      displayName: map['displayName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'createdAt': createdAt,
      'displayName': displayName,
    };
  }
}
