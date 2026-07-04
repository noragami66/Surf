import 'package:equatable/equatable.dart';

/// Authenticated client (api-contract `client` object).
class ClientEntity extends Equatable {
  const ClientEntity({
    required this.id,
    required this.phone,
    required this.name,
  });

  final String id;
  final String phone;
  final String name;

  bool get hasName => name.trim().isNotEmpty;

  ClientEntity copyWith({String? id, String? phone, String? name}) {
    return ClientEntity(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, phone, name];
}
