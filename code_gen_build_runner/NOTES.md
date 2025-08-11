#################################################
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

- none → Never run unless manually added under targets in a package's build.yaml.

- dependents → Run in any package that depends on your builder's package (most common for annotations/codegen).

- all_packages → Run in all packages in the build, even those that don't depend on your package. Rare.

- root_package → Run only in the main package being built (usually an app).

> NOTE: as explained above the the developers can explicitly define where the builders from our package should run in their project by defining a targets section inside the build.yaml in their project

Summary

#### Mental model
- Builders = 'what to run' (defined by the generator author; can auto-apply to dependents).

- Targets = 'where to run it in this package' (chosen by the package being built).

- \$default exists in every package (the app's \$default is not the same as your library's $default).

#### TL;DR
- Your library's targets: does not control the app.

- Use builders: + auto_apply: dependents to make your builder run in apps by default.

- The app's \$default target is what build_runner uses when building the app.

#################################################