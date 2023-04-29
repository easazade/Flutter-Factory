bash function tor run tests and generate and show code coverage.

```shell
function coveragegen(){
    dart pub global run coverage:test_with_coverage
    genhtml coverage/lcov.info -o coverage/html
    open coverage/html/index.html
}
```

**NOTE:** we need to activate `coverage` package globally first.