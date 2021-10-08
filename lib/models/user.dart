class User {
    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        this.registerDate,
        this.updatedDate,
    });

    final String id;
    final String firstName;
    final String lastName;
    final String email;
    final DateTime? registerDate;
    final DateTime? updatedDate;

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        registerDate: DateTime.parse(json["registerDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "registerDate": registerDate==null?null : registerDate!.toIso8601String(),
        "updatedDate": updatedDate==null?null : updatedDate!.toIso8601String(),
    };
}