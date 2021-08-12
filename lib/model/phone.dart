class Phone {
  final String phoneNumber;

  const Phone({
    this.phoneNumber,
  });

  Phone copy({
    String phoneNumber,
  }) =>
      Phone(
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  static Phone fromJson(Map<String, dynamic> json) => Phone(
        phoneNumber: json['phoneNumber'],
      );

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
      };
}
