/// DTO for the api-contract `client` object.
class ClientModel {
  const ClientModel({
    required this.id,
    required this.phone,
    required this.name,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'] as String,
      phone: json['phone'] as String,
      name: (json['name'] as String?) ?? '',
    );
  }

  final String id;
  final String phone;
  final String name;

  Map<String, dynamic> toJson() => {'id': id, 'phone': phone, 'name': name};
}
