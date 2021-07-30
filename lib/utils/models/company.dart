class Company {
  final String id;
  final String name;
  final String photoUrl;

  Company({this.id, this.name, this.photoUrl});

  Company fromFirebase(Map<String, dynamic> map, [String cId]) {
    return Company(name: map['name'], photoUrl: map['photoUrl'], id: cId);
  }
}
