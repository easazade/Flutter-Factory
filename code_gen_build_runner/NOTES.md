Inside the build.yaml there are 2 main sections targets and builders

targets are optional if you want to specifically define these builders should run on these directories you can define the targets in your consumer application. It is just for defining these builders need to run on these directories or packages. In short terms you are defining in this package run on these builders on these sources (source files)

>NOTE: targets has no effect outside the package it is defined in. each package and application in dart has its own targets. so in short targets section can only have effects on files and directories of the package it is defined in. In short targets section is per package.

NOTE: To define the scope of files of consumer apps that depend on our generator library it should be defined in the builders section, generally by defining the `auto_apply` scope. 

here is some example:

```yaml
targets:
  $default:
    sources:
      - lib/**
      - pubspec.yaml
    builders:
      my_generator|my_builder:
        enabled: true
```
we can define multiple targets inside the targets section
By default behind the scenes we already have a targets like below if in our top level builders section we have a builder defined.

```yaml
targets:
  $default:
    builders:
      my_builder:
        enabled: true
```

Here is a more complex version of a build.yaml file with only targets section create in an application that wants different builders from other libraries to be run on certain files inside the application files 

```yaml
# build.yaml (in your application package)

targets:
  $default:
    # Tell build_runner which files in THIS package are considered inputs.
    sources:
      - lib/**
      - pubspec.yaml
      - README.md

    builders:
      # 1) Run Builder A (from the first library) ONLY on pubspec.yaml and README.md
      first_library_package_name|first_builder_factory_method_name:
        enabled: true         # keep if that builder didn't set auto_apply
        generate_for:
          - pubspec.yaml
          - README.md

      # 2) Run Builder B (from the second library) on everything inside lib/
      second_library_package_name|second_builder_factory_method_name:
        enabled: true         # keep if that builder didn't set auto_apply
        generate_for:
          - lib/**

```

#### The dependencies property

the dependencies property inside a targets: section is one of the lesser-known build_runner features.
Here’s the simple version:

##### What it does
By default, a target’s builders can only read files inside that target (its own package).

If you add dependencies: to a target, you’re telling build_runner:
“This target is also allowed to read files from these other targets (other packages).”
This is read-only access — it lets your builders use outputs or inputs from other packages, but it does not let you modify those packages.

##### Simple example
Let's say you have:

```graphql
my_app/
my_generator/    # contains a builder that needs to read schema files from another package
shared_schemas/  # contains YAML schema files
```

Your app (my_app) depends on both my_generator and shared_schemas.

By default, if a builder in my_app tries to read shared_schemas/lib/foo.yaml, build_runner will block it — `not part of this target.`

But if you add:

```yaml
# my_app/build.yaml
targets:
  $default:
    dependencies:
      - shared_schemas
```

Now builders running in my_app are allowed to read files from shared_schemas during the build.

Why it's used
To aggregate or combine files from other packages (e.g., docs, configs, templates).

To make a builder that merges outputs from multiple packages into one final output in the app.

For multi-package code generation in a mono-repo.

#### auto_apply

Now we should also mention `auto_apply`:

inside the builders section when defining builders there is a field called auto_apply, which defines a general scope for the files this builder should run on when added to an application as library.

```yaml
builders:
  flutter_gen_runner:
    import: 'package:flutter_gen_runner/flutter_gen_runner.dart'
    builder_factories: ['build']
    build_extensions: { '$package$': ['.gen.dart'] }
    auto_apply: dependents
    build_to: source
```

`auto_apply` Takes 4 value, `none, dependents, root_package, all_packages`

auto_apply tells when your builder should automatically run in other packages without the developer explicitly enabling it in their build.yaml.

Values:

The four possible values
1️⃣ none
Meaning: Don’t run my builder unless the developer manually enables it in their build.yaml under targets:.

In an app using your library:
Your builder does nothing unless the app’s developer explicitly turns it on.

2️⃣ dependents ✅ (most common for generators)
Meaning: Run my builder in any package that depends on my package (either directly or indirectly).

In an app using your library:
As soon as the app adds your package to dependencies, your builder runs automatically on the app’s $default target without them adding anything to their build.yaml.

3️⃣ root_package
Meaning: Only run my builder in the root package being built — usually the app.

In an app using your library:
Your builder runs only in the main app package, not in any other packages the app depends on (even if those packages depend on your library).

4️⃣ all_packages
Meaning: Run my builder in every package in the build graph — your own library, the app, and all other dependencies.

In an app using your library:
Your builder runs everywhere — the app, your library, and any other package in the dependency tree.

Rarely used because it’s heavy and can slow builds.

> NOTE: as explained above the the developers can explicitly define where the builders from our package should run in their project by defining a targets section inside the build.yaml in their project

| `auto_apply` value | Runs in the app automatically? | Runs in other packages in the dependency tree? | Needs config in app’s build.yaml? |
| ------------------ | ------------------------------ | ---------------------------------------------- | --------------------------------- |
| `none`             | ❌ No                           | ❌ No                                           | ✅ Yes, must be enabled manually   |
| `dependents`       | ✅ Yes                          | ✅ Yes (if they depend on your lib)             | ❌ No                              |
| `root_package`     | ✅ Yes                          | ❌ No                                           | ❌ No                              |
| `all_packages`     | ✅ Yes                          | ✅ Yes (everywhere)                             | ❌ No                              |

**Here is a diagram:**

<img src="images/auto_apply_scope.png">

> “Does that change other libraries’ source code?”
No. Builders never edit original source files in other packages.
>
> For dependencies, any outputs are placed under .dart_tool/build/generated/<package>/... (ephemeral build outputs).
>
> Your builder might generate helpers/extensions for those packages during the build, but it doesn’t rewrite their checked-in code.
>
> Only the app’s own project files might see generated files next to them if your builder uses build_to: source (e.g., *.g.dart). Dependencies from pub/path don’t get their source trees mutated.

Summary

#### Mental model
- Builders = 'what to run' (defined by the generator author; can auto-apply to dependents).

- Targets = 'where to run it in this package' (chosen by the package being built).

- \$default exists in every package (the app's \$default is not the same as your library's $default).

#### TL;DR
- Your library's targets: does not control the app.

- Use builders: + auto_apply: dependents to make your builder run in apps by default.

- The app's \$default target is what build_runner uses when building the app.

## Builders

#### options

Alright — here’s how release options work in build.yaml and how to trigger them.

**1. What release_options is for**
In a builder definition, you can have different configuration sets depending on the build mode:

```yaml
builders:
  my_builder:
    import: "package:my_generator/builder.dart"
    builder_factories: ["myBuilder"]
    build_extensions: { ".dart": [".g.dart"] }
    build_to: source
    auto_apply: dependents
    defaults:
      options:            # <--- normal dev options
        minify: false
    release_options:      # <--- overrides for release builds
      minify: true
```
When you run in release mode, the release_options values override options.

**2. How to trigger a release build**
The default dart run build_runner build runs in development mode.

To use release_options, you must pass:
`dart run build_runner build --release`

**3. What happens**
build_runner sets the build environment to ReleaseBuildOptions.
Your builder sees options overridden by whatever is inside release_options.

Example: if minify was false in dev but true in release, your generator code will get true when reading the option in release mode.

**4. Common use cases**
- Turn off expensive debug logging in generated code
- Enable minification / obfuscation
- Change generated constants (e.g., API base URLs) for production

5. In your generator code
You read these values from the BuilderOptions your factory gets:

```dart
Builder myBuilder(BuilderOptions options) {
  final minify = options.config['minify'] as bool? ?? false;
  // Use minify flag in your generator logic...
}
```

#### How developers should configure options
It depends entirely on how they run build_runner in their app.

**1. If they just run:**
`dart run build_runner build`
or
`dart run build_runner watch`

➡ Your builder will use the defaults.options from your build.yaml (the “dev” options).
These are the same whether it’s the app or your own package running it — this is just the normal development mode.

**2. If they run with --release:**
`dart run build_runner build --release`

➡ Your builder will use the release_options from your build.yaml.
Those values override anything in defaults.options.

**3. Can they override these in their own app?**
Yes — the app can put its own build.yaml with global_options: or targets: to override both dev and release settings for your builder, for example:
```yaml
global_options:
  my_generator|my_builder:
    options:
      minify: false
    release_options:
      minify: true
```

This takes precedence over what you define in your library's build.yaml.

> When the app is the root package being built:
> `auto_apply: dependents` makes your builder run in the app's $default target automatically.
> Which options are applied (dev or release) depends only on whether the app runs build_runner with or without --release.


## Defining `PostProcessBuilder`s

`PostProcessBuilder`s are configured similarly to normal `Builder`s, but they
have some different/missing options.

These builders can not be auto-applied on their own, and must always build to
cache because their outputs are not declared ahead of time. To apply them a
user will need to explicitly enable them on a target, or a `Builder` definition
can add them to `apply_builders`.

Exposed `PostProcessBuilder`s are configured in the `post_process_builders`
section of the  `build.yaml`. This is a map of builder names to configuration.

A PostProcessBuilder is a special kind of builder in build_runner that runs after all normal builders are done.
It doesn't create Dart code — it's usually for final cleanup, transformations, or packaging.

Think of it like the "cleanup crew" after the construction workers are done.

Key points
- Runs after normal code generation is finished.
- Can read and modify generated outputs from other builders.
- Cannot read your original source files directly.
- Commonly used for:
  - Minifying, compressing, or obfuscating generated assets
  - Removing temporary files
  - Bundling generated files into zips
  - Formatting generated output


Each post process builder config may contain the following keys:

- **import**: Required. The import uri that should be used to import the library
  containing the `Builder` class. This should always be a `package:` uri.
- **builder_factory**: A `String` which contains the name of the top-level
  method in the imported library which is a function fitting the
  typedef `PostProcessBuilder factoryName(BuilderOptions options)`.
- **input_extensions**: Required. A list of input extensions that will be
  processed. This must match the `inputExtensions` from the `PostProcessBuilder`
  returned by the `builder_factory`.
- **defaults**: Optional: Default values to apply when a user does not specify
  the corresponding key in their `builders` section. May contain the following
  keys:
  - **generate_for**: A list of globs that this Builder should run on as a
    subset of the corresponding target, or a map with `include` and `exclude`
    lists of globs.

Example config with a normal `builder` which auto-applies a
`post_process_builder`:

```yaml
builders:
  # The regular builder config, creates `.tar.gz` files.
  regular_builder:
    import: "package:my_package/builder.dart"
    builder_factories: ["myBuilder"]
    build_extensions: {".dart": [".tar.gz"]}
    auto_apply: dependents
    apply_builders: [":archive_extract_builder"]
post_process_builders:
  # The post process builder config, extracts `.tar.gz` files.
  extract_archive_builder:
    import: "package:my_package/extract_archive_builder.dart"
    builder_factory: "myExtractArchiveBuilder"
    input_extensions: [".tar.gz"]
```

Another example:

```yaml
post_process_builders:
  minify_js:
    import: "package:my_generator/post_builders.dart"
    builder_factory: "minifyJsBuilder"
    input_extensions: [".js"]
    build_extensions: {".js": [".min.js"]}
    defaults:
      release_options:
        enabled: true

```


## Adjusting builder order

Normally, build_runner decides the order builders run in.  
If you need to **force a specific order**, you have two options:

- **`required_inputs`** → "I need to run *after* any builder that creates files with these extensions."  
  Example: a `.dart` compiler builder sets `required_inputs: [".dart"]` so it runs after all builders that generate Dart files.

- **`runs_before`** → "I must run *before* these specific builders."  
  Example: if Builder A creates `.json` files that Builder B reads, set `runs_before: [my_package|builder_b]` in Builder A.

⚠ These should be used rarely — don’t create cycles (A → B → A).

---

## **`applies_builders`**
- Ensures that another builder **always runs on the outputs** of this builder.
- Not just ordering — it actually applies the other builder to your outputs, even if it normally wouldn’t.
- Common example:  
  `SharedPartBuilder` sets:

```yaml
  applies_builders:
    - source_gen|combining_builder
```


## Package: source_gen
**source_gen** sits on top of the low-level **build** APIs and makes writing code generators way easier. It gives you a tiny “generator” abstraction, helpers for reading annotations/types, and ready-made *builders* that wire your generator into `build_runner`.

Here’s the quick tour.

#### What source_gen does (in plain terms)
- Lets you write a small class that **reads Dart elements** (classes, fields, annotations) and **returns a string of Dart code**.
- Handles the plumbing so your output lands in either:
  - a **shared `.g.dart` part** (so multiple generators can contribute to one file), or
  - a **standalone `*.gen.dart`** (your choice).
- Provides helpers to **inspect annotations**, **check types**, and **iterate a library’s elements**.

#### Core generator types
- **`Generator`**  
  Lowest-level base class. Override `generate(LibraryReader library, BuildStep step)` and emit code for the whole library.

- **`GeneratorForAnnotation<T>`**  
  Most common. You declare the annotation type `T`, and source_gen calls you **once per annotated element**. Override  
  `generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep step)`.

- **`GeneratorForLibrary`**  
  Like `Generator`, but with a slightly different hook focused on library-level work. Handy when you only want to generate once per library rather than per annotation.

> In practice, 90% of custom generators use **`GeneratorForAnnotation<T>`**.

#### The companion builders (how your generator plugs in)
These are utilities provided by source_gen that return a `build` **Builder** wrapping your generator:

- **`SharedPartBuilder([...generators], 'name')`**  
  Writes to `.g.dart` **parts** and coexists with other generators. Must pair with the `source_gen|combining_builder` (usually via `applies_builders`) so partial outputs get merged.

- **`LibraryBuilder(generator, generatedExtension: '.gen.dart')`**  
  Writes **standalone files**, one per input library. No `part` directive needed.

(There’s also `PartBuilder` for single-generator part files, but most folks just use `SharedPartBuilder`.)

#### Useful helper classes you’ll use a lot
- **`LibraryReader`** – Wraps an analyzer `LibraryElement` to iterate elements (classes, top-levels) more ergonomically.
- **`ConstantReader`** – Safely read annotation values (`annotation.peek('name')?.stringValue`, etc.)
- **`TypeChecker`** – Check types and supertypes without fragile string compares (e.g., `TypeChecker.fromRuntime(Foo).isAssignableFrom(type)`).
- **`InvalidGenerationSourceError`** – Throw this to give nice, pinpointed errors during generation.

(You'll still use the analyzer types like `Element`, `ClassElement`, `DartType` from `package:analyzer`, and `BuildStep` from `package:build`.)

#### Mini example: an annotation generator
**annotations package**
```dart
// lib/my_annotations.dart
class AutoToString {
  const AutoToString();
}
```

**generator package**
```dart
// lib/src/auto_to_string_generator.dart
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dart_style/dart_style.dart';
import 'package:my_annotations/my_annotations.dart';

class AutoToStringGenerator extends GeneratorForAnnotation<AutoToString> {
  final _fmt = DartFormatter();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep step,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@AutoToString can only be used on classes.',
        element: element,
      );
    }

    final cls = element;
    final fields = cls.fields.where((f) => !f.isStatic).toList();

    final buf = StringBuffer()
      ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
      ..writeln('extension ${cls.name}Auto on ${cls.name} {')
      ..writeln('  @override')
      ..writeln('  String toString() => "${cls.name}('
          '${fields.map((f) => '${f.name}: \${this.${f.name}}').join(', ')}'
          ')";')
      ..writeln('}');

    return _fmt.format(buf.toString());
  }
}
```

Wire it up with a builder:

```dart
// lib/builder.dart
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/auto_to_string_generator.dart';

Builder autoToStringSharedPart(BuilderOptions _) =>
    SharedPartBuilder([AutoToStringGenerator()], 'auto_to_string');
// or
Builder autoToStringLibrary(BuilderOptions _) =>
    LibraryBuilder(AutoToStringGenerator(), generatedExtension: '.auto.dart');
```

**build.yaml (generator package)**
```yaml
builders:
  auto_to_string_shared_part:
    import: "package:my_generator/builder.dart"
    builder_factories: ["autoToStringSharedPart"]
    build_extensions: { ".dart": [".g.dart"] }
    build_to: source
    auto_apply: dependents
    applies_builders:
      - source_gen|combining_builder

  auto_to_string_library:
    import: "package:my_generator/builder.dart"
    builder_factories: ["autoToStringLibrary"]
    build_extensions: { ".dart": [".auto.dart"] }
    build_to: source
    auto_apply: dependents
```

**consumer app**
```dart
import 'package:my_annotations/my_annotations.dart';
part 'user.g.dart'; // only if using SharedPartBuilder

@AutoToString()
class User {
  final String name;
  final int age;
  User(this.name, this.age);
}
```
Run:
```
dart run build_runner build
```

#### Typical use cases for source_gen
- **Serialization / deserialization** (e.g., `json_serializable`)
- **DI wiring / service locators** (collect annotated classes, generate registries)
- **Routing / reflection-like metadata** (scan annotations, generate maps/routers)
- **Immutables / data classes** (`copyWith`, `==`, `hashCode`, `toString`)
- **i18n / resource bundling** (turn ARB/JSON/YAML into typed Dart APIs)
- **Schema/code sync** (read external schema assets, emit Dart bindings)

#### How it fits with build_runner
- You write a `Generator` (your logic).
- You wrap it in a `SharedPartBuilder` or `LibraryBuilder`.
- You declare that builder in `build.yaml`.
- `build_runner` orchestrates: **reads your package code → calls your generator → writes outputs**.
- If you used `SharedPartBuilder`, the **`source_gen|combining_builder`** merges partial outputs into the final `.g.dart`.

If you tell me what you want to generate (e.g., registries, serializers, riverpod providers, DI), I can sketch a generator skeleton tailored to that use case.




#### Combining Builders (avoid rewriting .g.dart)

The **`combining_builder`** from the `source_gen` package is basically the “merger” for **`SharedPartBuilder`** outputs.  

---

### Why it exists
When you use `SharedPartBuilder`, **multiple generators** can each write to the same `.g.dart` file for a Dart library.  
- Instead of each generator overwriting the file, they each create a **partial output** during the build.  
- The `combining_builder` runs at the end and **combines all those partial outputs** into one `.g.dart` file that matches the `part '...';` in your source file.

---

### Example
You have one Dart file:

```dart
part 'user.g.dart';

@MyAnnotation()
class User {}

@JsonSerializable()
class Person {}
```

You run:
- `my_generator` → writes partial `.g.dart` with extensions for `User`
- `json_serializable` → writes partial `.g.dart` with `fromJson/toJson` for `Person`

Without `combining_builder`:
- They’d overwrite each other and you’d lose one of them.

With `combining_builder`:
- It merges all `.g.part` files into one final `user.g.dart` containing both `User` extensions and `Person` serialization code.

---

### Why `applies_builders` is used with it
In your builder definition:
```yaml
applies_builders:
  - source_gen|combining_builder
```
This ensures that **whenever** your `SharedPartBuilder` writes part outputs, the `combining_builder` will always run afterward to merge them.

**TL;DR**:  
`combining_builder` takes all the “partial” generated files from different `SharedPartBuilder`-based generators and merges them into the single `.g.dart` file that Dart expects for your `part` directive.


# Question & Answer
Let's say I have multiple GenerateForAnnotation implementations and they all run and generate something. now each time one of them runs and generates something I want to generate a metadata about what code they generated and then after they are done generating. I want to run a another Builder after them that uses all that metadata to generate a file with some code. my first question is can i save the metadata in .dart_tool/ and my second question is that is there a better more conventional way to do this?   

Great question — you're thinking about this exactly like a build pipeline.

$ Answered by ChatGPT 5$
### Short answers
1) **Can I save the metadata in `.dart_tool/`?**  
Yes. Set the builder that produces metadata to `build_to: cache`. Its outputs live under `.dart_tool/build/...` and are **not importable**, but any later builder can read them.

2) **Is there a more conventional way?**  
Yes: use a **two-stage build**:
- **Stage A (intermediate)**: produce per-library (or per-element) metadata files → **`build_to: cache`**.
- **Stage B (aggregator)**: read **all** those metadata files and emit your final Dart code → **`build_to: source`**.  
Wire order with `required_inputs` (and optionally `runs_before`) so B runs after A.

---

## Why not write metadata “inside” a `GeneratorForAnnotation`?
`source_gen` generators return a **single string** for code. They don’t let you emit arbitrary extra files per run. If you need sidecar files (like JSON metadata), implement a normal **`Builder`** (you can still use `source_gen` helpers like `LibraryReader`, `TypeChecker`, etc.), or have a parallel “metadata” builder that mirrors the selection logic.

---

## Minimal pattern

### A) Intermediate metadata builder (cache)
Writes one `.my.meta.json` for every input library it inspects.

**builder code (sketch):**
```dart
// lib/src/metadata_builder.dart
import 'dart:convert';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart'; // for LibraryReader/TypeChecker helpers

class MetadataBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.my.meta.json'],
  };

  @override
  Future<void> build(BuildStep step) async {
    if (!step.inputId.path.startsWith('lib/')) return; // scope to lib

    final lib = await step.resolver.libraryFor(step.inputId);
    final reader = LibraryReader(lib);

    // Example: collect names of annotated classes
    final meta = <String, dynamic>{
      'input': step.inputId.path,
      'classes': [
        for (final c in reader.classes)
          if (c.metadata.isNotEmpty) c.name, // replace with your checks
      ],
    };

    final outId = step.inputId.changeExtension('.my.meta.json');
    await step.writeAsString(outId, const JsonEncoder.withIndent('  ').convert(meta));
  }
}
```

**factory + build.yaml entry:**
```dart
// lib/builder.dart
import 'package:build/build.dart';
import 'src/metadata_builder.dart';

Builder metadataBuilder(BuilderOptions _) => MetadataBuilder();
```

```yaml
# build.yaml in your generator package
builders:
  my_metadata_builder:
    import: "package:my_generator/builder.dart"
    builder_factories: ["metadataBuilder"]
    build_extensions: { ".dart": [".my.meta.json"] }
    build_to: cache
    auto_apply: dependents
```

### B) Aggregator builder (source)
Reads **all** `.my.meta.json` files and generates one (or many) Dart files.

**builder code (sketch):**
```dart
// lib/src/aggregate_builder.dart
import 'dart:convert';
import 'package:build/build.dart';

class AggregateBuilder implements Builder {
  @override
  final buildExtensions = const {
    r'$package$': ['lib/aggregate_output.g.dart'], // single output for the package
  };

  @override
  Future<void> build(BuildStep step) async {
    // Discover every metadata file in the package
    final metas = <Map<String, dynamic>>[];
    await for (final id in step.findAssets(AssetId.glob('${step.inputId.package}/**/*.my.meta.json'))) {
      final jsonStr = await step.readAsString(id);
      metas.add(json.decode(jsonStr) as Map<String, dynamic>);
    }

    // Use metas to produce final Dart
    final buffer = StringBuffer()
      ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
      ..writeln('const generatedIndex = <String, List<String>>{');
    for (final m in metas) {
      final input = m['input'] as String;
      final classes = (m['classes'] as List).cast<String>();
      buffer.writeln("  '$input': ${classes.map((e) => "'$e'").toList()},");
    }
    buffer.writeln('};');

    final out = AssetId(step.inputId.package, 'lib/aggregate_output.g.dart');
    await step.writeAsString(out, buffer.toString());
  }
}
```

**factory + build.yaml entry (order + wiring):**
```dart
// lib/builder.dart
import 'package:build/build.dart';
import 'src/aggregate_builder.dart';

Builder aggregateBuilder(BuilderOptions _) => AggregateBuilder();
```

```yaml
builders:
  my_aggregate_builder:
    import: "package:my_generator/builder.dart"
    builder_factories: ["aggregateBuilder"]
    # Special input to produce a single package-level output:
    build_extensions: { r"$package$": ["lib/aggregate_output.g.dart"] }
    build_to: source
    auto_apply: dependents
    required_inputs: [".my.meta.json"]  # <-- ensures it runs after metadata is ready
```

> You can also add `runs_before` if another step must happen after aggregation, or add `applies_builders` if you want a follow-up builder to always run on the aggregator’s output.

---

## Variations & notes
- If you already have multiple `GeneratorForAnnotation`s making code via `SharedPartBuilder`, keep those, **plus** the metadata builder in parallel. The aggregator doesn’t need to parse the generated `.g.dart`; it can read the clean JSON from cache.
- If you want **one metadata file per element**, you can include the element name in the extension (e.g., write `foo.$ClassName.my.meta.json`). You’ll need to compute target `AssetId`s accordingly.
- Want to avoid duplicating the selection logic between generators and metadata? Consider **consolidating logic** inside a shared helper (e.g., `lib/src/scan.dart`) that both the generators and the metadata builder call.
- You could also do this with a **`PostProcessBuilder`** that scans generated outputs, but it’s less conventional than the **intermediate cache → aggregator** pattern, and parsing Dart can be brittle. Prefer structured cache metadata.

---

### TL;DR
- **Yes**, write metadata to `.dart_tool/build` by setting `build_to: cache`.  
- The **conventional** approach is a **two-stage pipeline**:  
  1) **Intermediate builder** writes structured metadata (cache).  
  2) **Aggregator builder** reads all metadata and emits final Dart (source), with `required_inputs` to ensure order.


---