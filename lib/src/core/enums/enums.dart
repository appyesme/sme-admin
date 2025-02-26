// ignore: constant_identifier_names
enum UserType { ENTREPRENEUR, USER, ADMIN }

extension UserTypeExt on String? {
  UserType? get getType {
    if (this == UserType.USER.name) return UserType.USER;
    if (this == UserType.ADMIN.name) return UserType.ADMIN;
    if (this == UserType.ENTREPRENEUR.name) return UserType.ENTREPRENEUR;
    return null;
  }
}

enum ApiVersion { v1, v2 }
