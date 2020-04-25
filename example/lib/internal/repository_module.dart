import 'package:example/data/repository/user_repository.dart';

import 'api_module.dart';

class RepositoryModule {
  static UserRepository _userRepository;

  static UserRepository userRepository() {
    if (_userRepository == null) {
      _userRepository = UserRepository(
        ApiModule.apiUtil(),
      );
    }
    return _userRepository;
  }
}
