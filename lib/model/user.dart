class User {
  final String firstName;
  final String lastName;

  const User({
    this.firstName,
    this.lastName,
  });

  User copy({
    String firstName,
    String lastName,
  }) =>
      User(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  static User fromJson(Map<String, dynamic> json) => User(
    firstName: json['firstName'],
    lastName: json['lastName'],
  );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
      };
}

