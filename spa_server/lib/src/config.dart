import 'package:envify/envify.dart';

part 'config.g.dart';

@Envify(path: '.env')
abstract class Env {
  static const String secretKey = _Env.secretKey;
  static const String mongoUrl = _Env.mongoUrl;
  static const bool isDebugMode = _Env.isDebugMode;
}


// we can define prod and test and staging if we need different env classes like below 
// @Envify(path: '.env.development')
// abstract class DevEnv {}

// @Envify(path: '.env.production')
// abstract class ProdEnv {}