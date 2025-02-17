import '../../../env_options.dart';
import '../enums/enums.dart';

const appName = "sme dashboard";

String apiUrl = EnvOptions.API_URL;

bool get isADMIN => userType == UserType.ADMIN;
bool get isLoggedIn => userId != null;

String? _userId;
String? get userId => _userId;
set userId(String? value) => _userId = value;

UserType? _userType;
UserType? get userType => _userType;
set userType(UserType? value) => _userType = value;

String? _authToken;
String? get authToken => _authToken;
set authToken(String? value) => _authToken = value;

// const List<BoxShadow> boxShadow = [BoxShadow(color: KColors.black10, blurRadius: 5)];
