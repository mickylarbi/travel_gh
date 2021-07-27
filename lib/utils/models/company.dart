class Company {
  final String name;
  final String photoUrl;

  Company({this.name, this.photoUrl});

  Company fromFirebase(Map<String, dynamic> map) {
    return Company(name: map['name'], photoUrl: map['photoUrl']);
  }
}
