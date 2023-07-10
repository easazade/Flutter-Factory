import 'package:serverpod/serverpod.dart';

class PremiumEndpoint extends Endpoint {
  Future<Map<String, String>> getPremiumData(Session session) async {
    return {'premium': 'content'};
  }

  @override
  bool get requireLogin => true;

  // @override
  // Set<Scope> get requiredScopes => {Scope('premium-user')};
}
