import 'package:example/data/api/service.dart';

import 'model/user.dart';

class ApiUtil {
  final Service _service;

  ApiUtil(this._service);

  Future<User> getUser(String login) {
    return _service.getUser(login);
  }
}
