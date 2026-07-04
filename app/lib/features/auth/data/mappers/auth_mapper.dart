import 'package:glina/features/auth/data/models/auth_tokens_model.dart';
import 'package:glina/features/auth/data/models/client_model.dart';
import 'package:glina/features/auth/domain/entities/auth_session.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';

extension ClientModelMapper on ClientModel {
  ClientEntity toEntity() => ClientEntity(id: id, phone: phone, name: name);
}

extension ClientEntityMapper on ClientEntity {
  ClientModel toModel() => ClientModel(id: id, phone: phone, name: name);
}

extension AuthTokensModelMapper on AuthTokensModel {
  AuthSession toEntity() => AuthSession(
    accessToken: accessToken,
    refreshToken: refreshToken,
    expiresIn: expiresIn,
    isNew: isNew,
    client: client.toEntity(),
  );
}
