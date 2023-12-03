class User {
  User({
    required this.ID,
    required this.userName,
    required this.nickName,
    required this.headerImg,
    required this.phone,
    required this.email,
  });


  final String userName;
  final String nickName;
  final String headerImg;
  final String phone;
  final String email;
  final int ID;
}