class Member {
  final String usid;
  final String pass;
  final String name;
  final String email;
  final String role;

  Member({
    required this.usid,
    required this.pass,
    required this.name,
    required this.email,
    this.role = 'USER'
  });

  Map<String, dynamic> toJson() {
    return {
      "usid": usid,
      "pass": pass,
      "name": name,
      "email": email,
      "role": role
    };
  }
}