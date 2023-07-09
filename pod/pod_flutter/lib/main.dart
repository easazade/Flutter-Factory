import 'package:pod_client/pod_client.dart';
import 'package:flutter/material.dart';
import 'package:pod_flutter/pages/general_page.dart';
import 'package:pod_flutter/pages/premium_page.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
late Client client;
late SessionManager sessionManager;

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  client = Client(
    'http://localhost:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  sessionManager = SessionManager(caller: client.modules.auth);
  await sessionManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(builder: (context) {
        return Material(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  child: const Text('General Page'),
                  onPressed: () =>
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GeneralPage())),
                ),
                ElevatedButton(
                  child: const Text('Premium Page'),
                  onPressed: () =>
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PremiumPage())),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
