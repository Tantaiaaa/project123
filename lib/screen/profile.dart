class Profile {
  var email;
  var password;
  String? name;
  var id;
  var phone;
  var group;

  Profile({
    this.email,
    this.password,
    this.name,
    this.id,
    this.phone,
    this.group,
  });

  factory Profile.fromMap(map) {
    return Profile(
      email: map('email'),
      password: map('password'),
      name: map('map'),
      id: map('id'),
      group: map('group'),
      phone: map('phone'),
    );
  }
}
