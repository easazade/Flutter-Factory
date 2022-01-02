- almost everything that can be done in dart devtools can be done programatically as well

- to gather information about the time it takes our app to start we can run our app with 
`flutter run --trace-startup --profile` 
and then check the `start_up_info.json` file created in `build` directory

- dart constant deduplication does not work in debug mode const widgets of flutter. since in debug mode some more code is added to trace the widget's location and info so for example this code will print 2 in debug mode while prints 1 in release

```dart
print(<Widget>{ // this is the syntax for a Set<Widget> literal
  const SizedBox(),
  const SizedBox(),
}.length);
```
to disable this in `debug-mode` use flag `--no-track-widget-creation` while running app
