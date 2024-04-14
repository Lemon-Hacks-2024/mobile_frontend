class RegistrationInformation {
  RegistrationInformation({
    required this.name,
    required this.lastName,
    required this.city,
    required this.mail,
    this.emailCode,
    this.phone,
    this.password,
  });

  final String name, lastName, city, mail;
  String? emailCode, phone, password;
}
