import 'package:pod_server/src/generated/secrets.dart';
import 'package:serverpod/serverpod.dart';

class SecretsEndpoint extends Endpoint {
  Future<void> getSecret(Session session) async {
    Secret.insert(session, Secret(phrase: 'phrase', publicKey: 'publicKey', privateKey: 'privateKey'));
    final allSecrets = await Secret.find(session);
    session.log('There are ${allSecrets.length.toString()} secrets in our database');
  }
}
