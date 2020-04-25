import 'package:example/data/api/api_util.dart';
import 'package:example/data/api/model/user.dart';

class UserRepository {
  final ApiUtil _apiUtil;

  UserRepository(this._apiUtil);

  Future<User> getUser(String login) async {
    return await _apiUtil.getUser(login);
  }
}
