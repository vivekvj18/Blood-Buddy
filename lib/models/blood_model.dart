class blood {
  String? uid;
  String? bloodType;
 

  blood({this.uid, this.bloodType, });

  // receiving data from server
  factory blood.fromMap(map) {
    return blood(
      uid: map['uid'],
      bloodType: map['bloodType'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'bloodType': bloodType,
    };
  }
}
