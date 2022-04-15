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
the default and we should set `lenient: true` when creating a template. 
- we can make a section of our template to be rendered by putting it in open close tags and set the value of the tag to true/false like `in_ca` tag.
- mustache is **logic-less** because there are no if statements, else clauses, or for loops. Instead there are only tags. Some tags are replaced with a value, some nothing, and others a series of values. This document explains the different types of Mustache tags.
- comments in mustache start witha bang -> `<h1>Today{{! ignore me }}.</h1>` which will render `<h1>Today.</h1>`. we can put new lines in comments if we need to 

#### Variable tags

- All variables are HTML escaped by default. eg if we use `<b>GitHub</b>` as tag value output of the variable will be `&lt;b&gt;GitHub&lt;/b&gt`. If you want to return unescaped HTML, use the triple mustache: `{{{name}}}` or use & => `{{& name}}`.
- by default all tag values will be empty if there is no value available for them in context. for `mustache_dart` package this is not 

#### Section tags

- Sections render blocks of text one or more times, depending on the value of the key in the current context.

- A section begins with a pound and ends with a slash. That is, {{#person}} begins a "person" section while {{/person}} ends it.

- For section tags we give value to their keys to specify their behaviour, like to be rendered or not. 

here is what different values do when given to section tags

- `false` or `empty list` => staction will not display

- anything other than above values => section will display

- `non empty list` => will be diplayed for each item in the list

Here is an example of mustache section tag iteration:

Template:
```mustache
{{#repo}}
  <b>{{name}}</b>
{{/repo}}
```
Hash:
```json
{
  "repo": [
    { "name": "resque" },
    { "name": "hub" },
    { "name": "rip" }
  ]
}
```
Output:
```html
<b>resque</b>
<b>hub</b>
<b>rip</b>
```

- passing lambda functions to section tags.

here is some example of passing lambda functions to section tags using `mustache_template` package

```dart
var t = new Template('{{# foo }}');
var lambda = (_) => 'bar';
t.renderString({'foo': lambda}); // bar


var t = new Template('{{# foo }}hidden{{/ foo }}');
var lambda = (_) => 'shown'};
t.renderString({'foo': lambda); // shown


var t = new Template('{{# foo }}oi{{/ foo }}');
var lambda = (LambdaContext ctx) => '<b>${ctx.renderString().toUpperCase()}</b>';
t.renderString({'foo': lambda}); // <b>OI</b>


var t = new Template('{{# foo }}{{bar}}{{/ foo }}');
var lambda = (LambdaContext ctx) => '<b>${ctx.renderString().toUpperCase()}</b>';
t.renderString({'foo': lambda, 'bar': 'pub'}); // <b>PUB</b>
```

- Non-False Values

When the value is non-false but not a list, it will be used as the context for a single rendering of the block.

Template:
```mustache
{{#person?}}
  Hi {{name}}!
{{/person?}}
```
Hash:
```json
{
  "person?": { "name": "Jon" }
}
```
Output:
```text
Hi Jon!
```
#### Inverted Sections

this section tag is basically like an else clause for a section tag. if there is no key in context for the section tag key or the value in context for that key is false or empty list the inverted tag with the same key if there is any will be rendered.  

Template:

```mustache
{{#repo}}
  <b>{{name}}</b>
{{/repo}}
{{^repo}}
  No repos :(
{{/repo}}
```
Hash:
```json
{
  "repo": []
}
```
Output:
```text
No repos :(
```

#### Nested Path

```dart
var t = new Template('{{ author.name }}');
var output = template.renderString({'author': {'name': 'Greg Lowe'}});
```

#### Partials

partials start with a greater than sign {{> user}}

Note that partials are rendered in runtime so make sure you avoid infinite loops

For example, this template and partial:

base.mustache:
```mustache
<h2>Names</h2>
{{#names}}
  {{> user}}
{{/names}}
```
user.mustache:
```mustache
<strong>{{name}}</strong>
```
Can be thought of as a single, expanded template:
```mustache
<h2>Names</h2>
{{#names}}
  <strong>{{name}}</strong>
{{/names}}
```


to use partials using `mustache_template` package we need a resolver to provide 

```dart

var partial = new Template('{{ foo }}', name: 'partial');

var resolver = (String name) {
   if (name == 'partial-name') { // Name of partial tag.
     return partial;
   }
};

var t = new Template('{{> partial-name }}', partialResolver: resolver);

var output = t.renderString({'foo': 'bar'}); // bar

```
#### Change Delimeters

by default mustache uses `{{` `}}` and as delimeters. but we can change delimeters if we neeed to using {{= =}}
for example we can set the delimters to <; ;> for open and close delimeters
 `{{=<; ;>=}}`. 
and we can also set it back to default with below code
<;={{ }}=;>
here is an example of how we can achieve this:

```mustach_template
* {{default_tags}}
{{=<% %>=}}
* <% erb_style_tags %>
<%={{ }}=%>
* {{ default_tags_again }}
```

#### More notes on mustache_template package

A template is parsed when it is created, after parsing it can be rendered any number of times with different values. A TemplateException is thrown if there is a problem parsing or rendering the template.

The Template contstructor allows passing a name, this name will be used in error messages. When working with a number of templates, it is important to pass a name so that the error messages specify which template caused the error.

By default all output from `{{variable}}` tags is html escaped, this behaviour can be changed by passing htmlEscapeValues : false to the Template constructor. You can also use a `{{{triple mustache}}}` tag, or a unescaped variable tag `{{&unescaped}}`, the output from these tags is not escaped.

#### Differences between strict mode and lenient mode. 

##### Strict mode (default) 
Tag names may only contain the characters a-z, A-Z, 0-9, underscore, period and minus. Other characters in tags will cause a TemplateException to be thrown during parsing.

During rendering, if no map key or object member which matches the tag name is found, then a TemplateException will be thrown.

##### Lenient mode 
Tag names may use any characters.
During rendering, if no map key or object member which matches the tag name is found, then silently ignore and output nothing.