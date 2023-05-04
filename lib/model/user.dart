class User {
  String firstName;
  String lastName;
  String patronymic;
  String phone;
  String email;

  User({
    required this.firstName,
    required this.lastName,
    required this.patronymic,
    required this.phone,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        patronymic: json["patronymic"],
        phone: json["phone"],
        email: json["email"]
        );
  }

  Map toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "patronymic": patronymic,
    "phone": phone,
    "email": email,
  };
}
