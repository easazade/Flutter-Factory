import 'package:serverpod/serverpod.dart';
import 'package:shared/shared.dart';

class CarEndpoint extends Endpoint {
  Future<Car> getCar(Session session) async => Car(name: 'BMW X6', brand: 'BMW');
}
