class User {
  String firstName;
  String lastName;
  String patronymic;
  String phone;

  User({
    required this.firstName,
    required this.lastName,
    required this.patronymic,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        patronymic: json["patronymic"],
        phone: json["phone"]
        );
  }

  Map toJson() => {
    "firstName": firstName,
    "lastName": firstName,
    "patronymic": firstName,
    "phone": firstName,
  };
}
