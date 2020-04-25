import 'package:example/data/api/api_util.dart';
import 'package:example/data/api/service.dart';

class ApiModule {
  static ApiUtil _apiUtil;

  static ApiUtil apiUtil() {
    if (_apiUtil == null) {
      _apiUtil = ApiUtil(
        Service(),
      );
    }
    return _apiUtil;
  }
}
