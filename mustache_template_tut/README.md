# Mustache for Dart

Here are some notes for mustache basics:
Here is a [link](https://mustache.github.io/mustache.5.html) to some mustache examples from mustache.github.io 

A typical Mustache template:
```mustache
Hello {{name}}
You have just won {{value}} dollars!
{{#in_ca}}
Well, {{taxed_value}} dollars, after taxes.
{{/in_ca}}
```
Given the following hash:
```json
{
  "name": "Chris",
  "value": 10000,
  "taxed_value": 10000 - (10000 * 0.4),
  "in_ca": true
}
```
Will produce the following:
```text
Hello Chris
You have just won 10000 dollars!
Well, 6000.0 dollars, after taxes.
```


- `{{name}}` , `{{#in_ca}}` & `{{/in_ca}}` are called tags in mustache. and the name inside is called tag's `key`.
- we have different tag types 

- All variables are HTML escaped by default. eg if we use `<b>GitHub</b>` as tag value output of the variable will be `&lt;b&gt;GitHub&lt;/b&gt`. If you want to return unescaped HTML, use the triple mustache: `{{{name}}}` or use & => `{{& name}}`.
- by default all tag values will be empty if there is no value available for them in context. for `mustache_dart` package this is not 
the default and we should set `lenient: true` when creating a template. 
- we can make a section of our template to be rendered by putting it in open close tags and set the value of the tag to true/false like `in_ca` tag.
- mustache is **logic-less** because there are no if statements, else clauses, or for loops. Instead there are only tags. Some tags are replaced with a value, some nothing, and others a series of values. This document explains the different types of Mustache tags.