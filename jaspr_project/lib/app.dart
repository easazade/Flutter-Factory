import 'package:jaspr/jaspr.dart';

part 'app.g.dart';

@app
class App extends StatelessComponent with _$App {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield DomComponent(
      tag: 'p',
      child: Text('Hello World is not hereeee'),
    );
  }
}
