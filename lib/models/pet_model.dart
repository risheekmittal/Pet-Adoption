class Pet {
  final String id;  // Unique identifier for each pet
  final String name;
  final String imageUrl;
  final int age;
  final String breed;
  final double price;
  bool isAdopted;
  String? adoptionDate;

  Pet({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.age,
    required this.breed,
    required this.price,
    this.isAdopted = false,
    this.adoptionDate,
  });

  @override
  String toString() {
    return 'Pet{id: $id, name: $name, imageUrl: $imageUrl, age: $age, breed: $breed, price: $price, isAdopted: $isAdopted, adoptionDate: $adoptionDate}';
  }

  // Convert JSON into Pet object
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      age: json['age'] ?? '',
      breed: json['breed'] ?? '',
      price: json['price'] ?? 0.0,
      isAdopted: json['isAdopted'] ?? false,
      adoptionDate: json['adoptionDate'],
    );
  }

  // Convert Pet object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'age': age,
      'breed': breed,
      'price': price,
      'isAdopted': isAdopted,
      'adoptionDate': adoptionDate,
    };
  }

  // To convert a Map<String, dynamic> to Pet object
  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      age: map['age'] ?? '',
      breed: map['breed'] ?? '',
      price: map['price'] ?? 0.0,
      isAdopted: map['isAdopted'] ?? false,
    );
  }
}
