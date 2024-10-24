class UserModel {
  String? fullName;
  String? email;
  String? profilePic;
  String? number;
  String? uid;

  UserModel({
    required this.fullName,
    required this.email,
    required this.profilePic,
    required this.uid,
    required this.number,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    profilePic = json['profilePic'];
    number = json['number'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['profilePic'] = this.profilePic;
    data['number']= this.number;
    data['uid'] = this.uid;
    return data;
  }
}