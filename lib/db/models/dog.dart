class Dog {
  final int? id;
  final String name;
  final int age;

  const Dog({
    this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
  factory Dog.fromMap(Map<String, dynamic> json) => Dog(
    id: json['id'],
    name: json['name'],
    age: json['age']
  );

}
