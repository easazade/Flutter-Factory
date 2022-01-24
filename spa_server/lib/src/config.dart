import 'package:envify/envify.dart';

part 'config.g.dart';

@Envify(path: '.env')
abstract class Env {
  static const secretKey = _Env.secretKey;
  static const mongoUrl = _Env.mongoUrl;
}


// we can define prod and test and staging if we need different env classes like below 
// @Envify(path: '.env.development')
// abstract class DevEnv {}

// @Envify(path: '.env.production')
// abstract class ProdEnv {}