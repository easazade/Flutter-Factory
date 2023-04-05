Checking out how to read metadata for code generation using analyzer.

came across [serverpod](https://pub.dev/packages/serverpod) which uses analyzer to read metadata from existing code 
and then uses that metadata for code generation.

I used dart mirror api before to do the same. but dart mirror api is no longer being developed, and it does 
not support null safety. there is also an issue to drop or deprecate it. (don't think that would happen though). 