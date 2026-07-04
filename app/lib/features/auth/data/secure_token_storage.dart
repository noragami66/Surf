import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:glina/features/auth/data/mappers/auth_mapper.dart';
import 'package:glina/features/auth/data/models/client_model.dart';
import 'package:glina/features/auth/data/token_storage.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';

class SecureTokenStorage implements ITokenStorage {
  SecureTokenStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';
  static const _clientKey = 'client';
  static const _accessExpiresKey = 'access_expires_at';

  final FlutterSecureStorage _storage;

  @override
  Future<void> clear() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
    await _storage.delete(key: _clientKey);
    await _storage.delete(key: _accessExpiresKey);
  }

  @override
  Future<DateTime?> readAccessExpiresAt() async {
    final raw = await _storage.read(key: _accessExpiresKey);
    if (raw == null) {
      return null;
    }
    return DateTime.tryParse(raw);
  }

  @override
  Future<void> saveAccessExpiresAt(DateTime expiresAt) async {
    await _storage.write(
      key: _accessExpiresKey,
      value: expiresAt.toUtc().toIso8601String(),
    );
  }

  @override
  Future<String?> readAccessToken() => _storage.read(key: _accessKey);

  @override
  Future<String?> readRefreshToken() => _storage.read(key: _refreshKey);

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }

  @override
  Future<void> saveClient(ClientEntity client) async {
    final json = jsonEncode(client.toModel().toJson());
    await _storage.write(key: _clientKey, value: json);
  }

  @override
  Future<ClientEntity?> readClient() async {
    final raw = await _storage.read(key: _clientKey);
    if (raw == null) {
      return null;
    }
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return ClientModel.fromJson(json).toEntity();
  }
}
