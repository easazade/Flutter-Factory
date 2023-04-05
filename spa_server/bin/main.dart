import 'package:shelf_hotreload/shelf_hotreload.dart';

import 'package:spa_server/spa_server.dart';

void main(List<String> arguments) async {
  withHotreload(() => createHttpServer());
}
